# Recipe Data Format

All recipes currently live in `recipes.yml`. Keep settings in the established order so entries remain easy to compare and can later be rendered consistently on a website.

## Recipe fields

```yaml
- name: Recipe Name
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
    clarity: null

  source:
    creator: Creator Name
    url: https://example.com/
```

## Missing and unavailable values

Use these defaults when a source does not provide a setting:

- Use `Off` for settings that support an `Off` value.
- Use `0` for omitted numeric settings, including white-balance shifts, Tone Curve, Color, Sharpness, and High ISO NR.
- Use `null` for Clarity when it is not provided.
- Use `null` for Monochromatic Color when it does not apply or is not provided.
- Use `null` for dependent settings that do not have an `Off` value, such as Grain Size when Grain Roughness is `Off`.
- Use `null` for a camera slot when the recipe is not loaded on the camera.
- A non-numeric setting without an `Off` option may use `null` when the source does not provide it.

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

## White Balance

White Balance contains only `mode`, `red_shift`, and `blue_shift`.

Allowed named `mode` values:

- `Auto White Priority`
- `Auto`
- `Auto Ambience Priority`
- `Custom 1`
- `Custom 2`
- `Custom 3`
- `Daylight`
- `Shade`
- `Fluorescent Light - 1`
- `Fluorescent Light - 2`
- `Fluorescent Light - 3`
- `Incandescent`
- `Underwater`

For a color-temperature white balance, use the Kelvin value directly as the mode:

```yaml
white_balance:
  mode: 5800K
  red_shift: 2
  blue_shift: -2
```

For a named mode:

```yaml
white_balance:
  mode: Auto
  red_shift: 2
  blue_shift: -2
```

If red or blue shifts are not provided, use `0`.

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

Use `Off` when it is not provided.

## Tone Curve

Both `highlights` and `shadows` range from `-4` to `4` in increments of `0.5`. Use `0` when either value is not provided.

## Color

Ranges from `-4` to `4` in increments of `1`. Use `0` when not provided.

## Sharpness

Ranges from `-4` to `4` in increments of `1`. Use `0` when not provided.

## High ISO NR

Ranges from `-4` to `4` in increments of `1`. Use `0` when not provided.

## Clarity

Ranges from `-5` to `5` in increments of `1`. Use `null` when not provided.

## Modified recipes

Modified versions remain separate entries and use the naming pattern:

```yaml
name: Recipe Name (Modified)
```

Repeat every setting in the modified entry, including unchanged values. This makes each entry complete and usable on its own.
