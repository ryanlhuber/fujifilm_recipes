# Fujifilm Recipes

A personal collection of Fujifilm film simulation recipes, organized for the Fujifilm X-E5.

The repository starts with one YAML file so recipes are easy to add and maintain. The structure is designed to support a future searchable website without requiring the collection to be rewritten.

## Files

- `recipes.yml` — source of truth for recipes, camera slots, settings, and sources
- `docs/data-format.md` — conventions for adding recipes

## Camera slots

Recipes currently loaded on the camera use one of these values:

- `C1` through `C7`
- `FS1` through `FS3`

Recipes that are not loaded use YAML `null`.

## Modified recipes

Modified versions remain separate recipe entries and use the naming pattern:

```yaml
name: Recipe Name (Modified)
```

Each modified recipe repeats the complete set of settings so it can be entered into the camera without cross-referencing the original.

## Current recipes

| Slot | Recipe | Creator |
| --- | --- | --- |
| C1 | Stillness | Gyu-yeon Lee |
| C2 | Anime | Jason Vong |
| C3 | Pro Neg. Portrait | Derrick Ong |
| C4 | Mt. Fujicolor Velvia (Modified) | Keigo Suzuki |
| C5 | Tokyo Dream (Modified) | Ivan Yolo |
| C6 | Mika Ninagawa | self |
| C7 | Leica Monochrom (Modified) | Ivan Yolo |
| FS1 | Reggie's Portra | Reggie Ballesteros |
