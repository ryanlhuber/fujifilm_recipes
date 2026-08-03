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
| FS2 | Reggie's Superia | Reggie Ballesteros |
| FS3 | Reggie's HP5 | Reggie Ballesteros |

## Unassigned recipes

These recipes are saved in the collection but are not currently loaded into a camera slot.

| Recipe | Creator |
| --- | --- |
| Mt. Fujicolor Velvia | Keigo Suzuki |
| Tokyo Dream | Ivan Yolo |
| Leica Monochrom | Ivan Yolo |
| Dreaming | Alex Hayes |
| Dreaming (Modified) | Alex Hayes |
| Teal Obscure | Ivan Yolo |
| Velvet Shade | Ivan Yolo |
| Kurosawa | self |
| Ansel Adams | self |
| Dreamy Purple | Ivan Yolo |
| Natura Classic Film | Ivan Yolo |
| Ginza 1980 | Ivan Yolo |
| Moody Metropolis 500T | Ivan Yolo |
| Sunburst | Naoya Takahashi |
| Summer Evening Glow | Yuri Nanasaki |
| Vintage Bronze | Ritchie Roesch |
| Vibrant Astia Soft | Osan Bilgi |
