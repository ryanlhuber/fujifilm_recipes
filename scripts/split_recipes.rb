#!/usr/bin/env ruby
# frozen_string_literal: true

require "fileutils"
require "yaml"

LEGACY_SOURCE_PATH = "recipes.yml"
RECIPES_DIR = "recipes"
GENERATED_DIR = "generated"
GENERATED_PATH = File.join(GENERATED_DIR, "recipes.yml")
NULL_SENTINEL = "__FUJI_NULL__"

METADATA = {
  "schema_version" => 1,
  "primary_camera" => "Fujifilm X-E5"
}.freeze

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

def migrate_legacy_collection!
  return unless File.exist?(LEGACY_SOURCE_PATH)

  data = YAML.safe_load(File.read(LEGACY_SOURCE_PATH), permitted_classes: [], aliases: false)
  recipes = data.fetch("recipes")
  FileUtils.mkdir_p(RECIPES_DIR)

  recipes.each do |recipe|
    normalized = normalize_yaml_values(recipe)
    validate_no_boolean_settings!(normalized)
    path = File.join(RECIPES_DIR, "#{slugify(normalized.fetch('name'))}.yml")
    File.write(path, dump_yaml(normalized))
  end
end

migrate_legacy_collection!

recipe_paths = Dir.glob(File.join(RECIPES_DIR, "*.yml")).sort
abort "No individual recipe files found in #{RECIPES_DIR}/." if recipe_paths.empty?

recipes = recipe_paths.map do |path|
  recipe = YAML.safe_load(File.read(path), permitted_classes: [], aliases: false)
  recipe = normalize_yaml_values(recipe)
  validate_no_boolean_settings!(recipe)
  recipe
end

names = recipes.map { |recipe| recipe.fetch("name") }
duplicates = names.group_by(&:itself).select { |_name, matches| matches.length > 1 }.keys
abort "Duplicate recipe names found: #{duplicates.join(', ')}" unless duplicates.empty?

FileUtils.mkdir_p(GENERATED_DIR)
combined = {
  "metadata" => METADATA,
  "recipes" => recipes
}
File.write(GENERATED_PATH, dump_yaml(combined))

puts "Read #{recipes.length} recipe files from #{RECIPES_DIR}/"
puts "Created #{GENERATED_PATH}"
