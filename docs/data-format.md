# Recipe Data Format

All recipes currently live in `recipes.yml`. Keep settings in the established order so entries remain easy to compare and can later be rendered consistently on a website.

## Recipe fields

```yaml
- id: recipe-name
  name: Recipe Name
  version: original
  parent_recipe: null

  favorite: false
  camera_slot: null

  settings:
    film_simulation: Pro Neg. Std

    monochrome_color:
      wc: null
      mg: null

    grain_effect:
      roughness: Off
      size: null

    color_chrome_effect: Strong
    color_chrome_fx_blue: Weak
    smooth_skin_effect: Off

    white_balance:
      mode: Auto
      color_temperature: null
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

## Empty and unavailable values

Use YAML `null` when a setting is unavailable, does not apply, was not provided by the source, or when a recipe is not loaded into a camera slot.

## Camera slots

Allowed values:

- `C1` through `C7`
- `FS1` through `FS3`
- `null` when not loaded

## Film Simulation

Allowed values:

- `Provia`
- `Velvia`
- `Astia`
- `Classic Chrome`
- `Reala Ace`
- `Pro Neg. Hi`
- `Pro Neg. Std`
- `Classic Neg.`
- `Nostalgic Neg.`
- `Eterna/Cinema`
- `Eterna Bleach Bypass`
- `Acros/STD`
- `Acros/Ye`
- `Acros/R`
- `Acros/G`
- `Monochrome/STD`
- `Monochrome/Ye`
- `Monochrome/R`
- `Monochrome/G`
- `Sepia`

Acros and Monochrome use the `Film/Filter` pattern:

```yaml
film_simulation: Acros/Ye
```

```yaml
film_simulation: Monochrome/G
```

## Film Grain

`roughness` values:

- `Off`
- `Weak`
- `Strong`

`size` values:

- `Small`
- `Large`
- `null` when roughness is `Off`

## Color Chrome Effect

- `Off`
- `Weak`
- `Strong`

## Color Chrome FX Blue

- `Off`
- `Weak`
- `Strong`

## Smooth Skin Effect

- `Off`
- `Weak`
- `Strong`
- `null` when unavailable or not provided

## White Balance

Allowed `mode` values:

- `Auto White Priority`
- `Auto`
- `Auto Ambience Priority`
- `Custom 1`
- `Custom 2`
- `Custom 3`
- `Color Temperature`
- `Daylight`
- `Shade`
- `Fluorescent Light - 1`
- `Fluorescent Light - 2`
- `Fluorescent Light - 3`
- `Incandescent`
- `Underwater`

Every mode includes numeric `red_shift` and `blue_shift` values.

When `mode` is `Color Temperature`, store the Kelvin value in `color_temperature`:

```yaml
white_balance:
  mode: Color Temperature
  color_temperature: 5800K
  red_shift: 2
  blue_shift: -2
```

For all other modes, use `color_temperature: null`.

## Dynamic Range

- `Auto`
- `DR100`
- `DR200`
- `DR400`

## D Range Priority

- `Off`
- `Weak`
- `Strong`
- `Auto`

## Tone Curve

Both `highlights` and `shadows` range from `-4` to `4` in increments of `0.5`.

## Color

Ranges from `-4` to `4` in increments of `1`.

## Sharpness

Ranges from `-4` to `4` in increments of `1`.

## High ISO NR

Ranges from `-4` to `4` in increments of `1`.

## Clarity

Ranges from `-5` to `5` in increments of `1`.

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

## IDs

Use lowercase kebab-case IDs based on the recipe name:

```yaml
id: stillness
id: classic-cuban-negative
id: classic-cuban-negative-modified
```
