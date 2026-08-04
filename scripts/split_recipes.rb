#!/usr/bin/env ruby
# frozen_string_literal: true

require "fileutils"
require "open3"
require "yaml"

LEGACY_SOURCE_PATH = "recipes.yml"
RECIPES_DIR = "recipes"
GENERATED_DIR = "generated"
GENERATED_PATH = File.join(GENERATED_DIR, "recipes.yml")
RECOVERY_REF = "a7c047a954b5fc4b8515718bea3dc7ce68106aa2:generated/recipes.yml"
NULL_SENTINEL = "__FUJI_NULL__"

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

def prepare_for_dump(value)
  case value
  when Hash
    value.transform_values { |item| prepare_for_dump(item) }
  when Array
    value.map { |item| prepare_for_dump(item) }
  when nil
    NULL_SENTINEL
  else
    value
  end
end

def dump_yaml(value)
  YAML.dump(prepare_for_dump(value))
    .sub(/^---\s*\n/, "")
    .gsub(/['\"]?#{NULL_SENTINEL}['\"]?/, "null")
    .gsub(/['\"]Off['\"]/, "Off")
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

def load_collection
  source_path = if File.exist?(LEGACY_SOURCE_PATH)
                  LEGACY_SOURCE_PATH
                elsif File.exist?(GENERATED_PATH)
                  GENERATED_PATH
                else
                  abort "No recipe collection found to split."
                end

  YAML.safe_load(File.read(source_path), permitted_classes: [], aliases: false)
rescue Psych::SyntaxError
  recovered, status = Open3.capture2("git", "show", RECOVERY_REF)
  abort "Could not recover the pre-migration recipe collection." unless status.success?

  YAML.safe_load(recovered, permitted_classes: [], aliases: false)
end

data = normalize_yaml_values(load_collection)
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
