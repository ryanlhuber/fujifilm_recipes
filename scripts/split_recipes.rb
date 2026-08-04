#!/usr/bin/env ruby
# frozen_string_literal: true

require "fileutils"
require "yaml"

LEGACY_SOURCE_PATH = "recipes.yml"
RECIPES_DIR = "recipes"
GENERATED_DIR = "generated"
GENERATED_PATH = File.join(GENERATED_DIR, "recipes.yml")

UNUSED_SETTING_KEYS = %w[
  roughness
  color_chrome_effect
  color_chrome_fx_blue
  smooth_skin_effect
  d_range_priority
].freeze

def slugify(name)
  name
    .downcase
    .gsub(/[’']/, "")
    .gsub(/[^a-z0-9]+/, "-")
    .gsub(/\A-+|-+\z/, "")
end

def normalize_yaml_values(value, key = nil)
  case value
  when Hash
    value.to_h { |child_key, item| [child_key, normalize_yaml_values(item, child_key)] }
  when Array
    value.map { |item| normalize_yaml_values(item) }
  when false
    "Off"
  when nil
    UNUSED_SETTING_KEYS.include?(key) ? "Off" : nil
  else
    value
  end
end

def dump_yaml(value)
  YAML.dump(value)
    .gsub(/^---\s*\n/, "")
    .gsub(/^(\s*[^\s][^:\n]*:)\s*$/, "\\1 null")
end

def validate_no_boolean_settings!(value, path = [])
  case value
  when Hash
    value.each { |key, item| validate_no_boolean_settings!(item, path + [key]) }
  when Array
    value.each_with_index { |item, index| validate_no_boolean_settings!(item, path + [index]) }
  when true, false
    abort "Boolean setting found at #{path.join('.')}; use Off or an explicit setting value."
  end
end

source_path = if File.exist?(LEGACY_SOURCE_PATH)
                LEGACY_SOURCE_PATH
              elsif File.exist?(GENERATED_PATH)
                GENERATED_PATH
              else
                abort "No recipe collection found to split."
              end

data = YAML.safe_load(File.read(source_path), permitted_classes: [], aliases: false)
data = normalize_yaml_values(data)
validate_no_boolean_settings!(data)
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
  File.write(File.join(RECIPES_DIR, "#{slug}.yml"), dump_yaml(recipe))
end

combined = {
  "metadata" => metadata,
  "recipes" => recipes
}

File.write(GENERATED_PATH, dump_yaml(combined))

puts "Created #{recipes.length} recipe files in #{RECIPES_DIR}/"
puts "Created #{GENERATED_PATH}"
