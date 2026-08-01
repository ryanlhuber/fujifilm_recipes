# Recipe Data Format

All recipes currently live in `recipes.yml`. Keep settings in the established order so entries remain easy to compare and can later be rendered consistently on a website.

## Recipe fields

```yaml
- id: recipe-name
  name: Recipe Name
  version: original
  parent_recipe: null

  status: interested
  favorite: false
  camera_slot: null

  compatibility:
    sensor_generation: X-Trans CMOS 5

  settings:
    film_simulation: Pro Neg. Std

    monochrome_color:
      wc: null
      mg: null

    grain_effect:
      strength: Off
      size: null

    color_chrome_effect: Strong
    color_chrome_fx_blue: Weak
    smooth_skin_effect: null

    white_balance:
      mode: Auto
      red_shift: 0
      blue_shift: 0

    dynamic_range: DR200
    d_range_priority: Off

    tone_curve:
      highlights: 0
      shadows: 0

    color: 0
    sharpness: 0
    high_iso_nr: 0
    clarity: 0

  source:
    creator: Creator Name
    name: Source Page or Recipe Name
    url: https://example.com/

  notes: null
```

## Empty and unavailable settings

Use YAML `null` when a setting is unavailable, does not apply, or was not provided by the source. Do not store `N/A`, `NA`, or an em dash as text.

Examples:

```yaml
smooth_skin_effect: null
```

```yaml
monochrome_color:
  wc: null
  mg: null
```

## White balance

Store the white-balance mode separately from the red and blue shifts:

```yaml
white_balance:
  mode: Auto
  red_shift: 2
  blue_shift: -2
```

## Grain effect

Grain Effect supports strength and size. When Grain Effect is off, use:

```yaml
grain_effect:
  strength: Off
  size: null
```

## Original and modified recipes

Original recipes use:

```yaml
version: original
parent_recipe: null
```

A personal variation uses the original recipe's ID as its parent:

```yaml
id: recipe-name-modified
name: Recipe Name (Modified)
version: modified
parent_recipe: recipe-name
```

Repeat every setting in the modified entry, including unchanged values. This makes each entry complete and usable on its own.

## Status and slot rules

Allowed status values:

- `interested`
- `testing`
- `active`
- `archived`

Allowed camera slots:

- `C1` through `C7`
- `FS1` through `FS3`
- `null` when not loaded

A recipe using a camera slot should normally have `status: active`.

## IDs

Use lowercase kebab-case IDs based on the recipe name:

```yaml
id: stillness
id: classic-cuban-negative
id: classic-cuban-negative-modified
```
