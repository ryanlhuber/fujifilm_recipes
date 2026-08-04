#!/usr/bin/env ruby
# frozen_string_literal: true

require "fileutils"
require "yaml"

SOURCE_PATH = "recipes.yml"
RECIPES_DIR = "recipes"
GENERATED_DIR = "generated"
GENERATED_PATH = File.join(GENERATED_DIR, "recipes.yml")

def slugify(name)
  name
    .downcase
    .gsub(/[’']/, "")
    .gsub(/[^a-z0-9]+/, "-")
    .gsub(/\A-+|-+\z/, "")
end

unless File.exist?(SOURCE_PATH)
  warn "#{SOURCE_PATH} does not exist; nothing to migrate."
  exit 0
end

data = YAML.safe_load(File.read(SOURCE_PATH), permitted_classes: [], aliases: false)
metadata = data.fetch("metadata")
recipes = data.fetch("recipes")

FileUtils.rm_rf(RECIPES_DIR)
FileUtils.mkdir_p(RECIPES_DIR)
FileUtils.mkdir_p(GENERATED_DIR)

used_slugs = {}
recipes.each do |recipe|
  base_slug = slugify(recipe.fetch("name"))
  slug = base_slug
  suffix = 2

  while used_slugs.key?(slug)
    slug = "#{base_slug}-#{suffix}"
    suffix += 1
  end

  used_slugs[slug] = true
  File.write(File.join(RECIPES_DIR, "#{slug}.yml"), YAML.dump(recipe))
end

combined = {
  "metadata" => metadata,
  "recipes" => recipes
}

File.write(GENERATED_PATH, YAML.dump(combined))

puts "Created #{recipes.length} recipe files in #{RECIPES_DIR}/"
puts "Created #{GENERATED_PATH}"
