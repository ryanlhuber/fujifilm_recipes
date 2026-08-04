# Recipe Data Format

Each recipe lives in its own file under `recipes/`. The filename is a lowercase kebab-case version of the recipe name, such as `recipes/teal-obscure.yml`.

`generated/recipes.yml` combines the full collection for consumers that need one file. It is generated output and should not be edited directly.

Keep settings in the established order so recipes remain easy to compare and can later be rendered consistently on a website.

## Recipe file

Each file contains one complete recipe object:

```yaml
name: Recipe Name
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

## Source

Use the recipe creator's name and original page or video URL when available. For an original recipe created for this collection, use:

```yaml
source:
  creator: self
```

The source URL is optional when there is no external source.

## Missing and unavailable values

- Use `Off` for settings that support an `Off` value.
- Use `0` for omitted numeric settings, including white-balance shifts, Tone Curve, Color, Sharpness, and High ISO NR.
- Use `null` for Clarity when it is not provided.
- Use `null` for Monochromatic Color when it does not apply or is not provided.
- Use `null` for dependent settings without an `Off` value, such as Grain Size when Grain Roughness is `Off`.
- Use `null` for a camera slot when the recipe is not loaded.

## Allowed values

### Camera slot

`C1`–`C7`, `FS1`–`FS3`, or `null`.

### Film simulation

`Provia`, `Velvia`, `Astia`, `Classic Chrome`, `Reala Ace`, `Pro Neg. Hi`, `Pro Neg. Std`, `Classic Neg.`, `Nostalgic Neg.`, `Eterna/Cinema`, `Eterna Bleach Bypass`, `Acros/STD`, `Acros/Ye`, `Acros/R`, `Acros/G`, `Monochrome/STD`, `Monochrome/Ye`, `Monochrome/R`, `Monochrome/G`, or `Sepia`.

Acros and Monochrome use the `Film/Filter` pattern.

### Grain effect

- `roughness`: `Off`, `Weak`, or `Strong`
- `size`: `Small`, `Large`, or `null` when roughness is `Off`

### Color Chrome, Color Chrome FX Blue, and Smooth Skin

`Off`, `Weak`, or `Strong`.

### White balance

Named modes: `Auto White Priority`, `Auto`, `Auto Ambience Priority`, `Custom 1`, `Custom 2`, `Custom 3`, `Daylight`, `Shade`, `Fluorescent Light - 1`, `Fluorescent Light - 2`, `Fluorescent Light - 3`, `Incandescent`, or `Underwater`.

A Kelvin value may be used directly, such as `5800K`. Red and blue shifts default to `0`.

### Dynamic range

`Auto`, `DR100`, `DR200`, or `DR400`.

### D Range Priority

`Off`, `Weak`, `Strong`, or `Auto`. Use `Off` when not provided.

### Numeric settings

- Tone Curve highlights and shadows: `-4` to `4` in `0.5` increments
- Color, Sharpness, and High ISO NR: `-4` to `4` in increments of `1`
- Clarity: `-5` to `5` in increments of `1`, or `null`

## Modified recipes

Modified versions remain separate files and use:

```yaml
name: Recipe Name (Modified)
```

Repeat every setting, including unchanged values, so each recipe remains complete and usable on its own.
