# Fujifilm Recipes

A personal collection of Fujifilm film simulation recipes, organized for the Fujifilm X-E5.

The repository starts with one YAML file so recipes are easy to add and maintain. The structure is designed to support a future searchable website without requiring the collection to be rewritten.

## Files

- `recipes.yml` — source of truth for recipes, camera slots, settings, and sources
- `docs/data-format.md` — conventions for adding and modifying recipes

## Camera slots

Recipes currently loaded on the camera use one of these values:

- `C1` through `C7`
- `FS1` through `FS3`

Recipes that are not loaded use YAML `null`.

## Favorites

Favorites can be tracked separately with `favorite: true` or `favorite: false`.

## Modified recipes

Modified versions remain separate entries but link back to the original recipe:

```yaml
name: Recipe Name (Modified)
version: modified
parent_recipe: original-recipe-id
```

Each modified recipe repeats the complete set of settings so it can be entered into the camera without cross-referencing the original.

## Current recipes

| Slot | Recipe | Creator |
| --- | --- | --- |
| C1 | Stillness | Gyu-yeon Lee |
