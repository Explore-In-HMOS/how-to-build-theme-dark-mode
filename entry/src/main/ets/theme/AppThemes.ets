import { CustomColors, CustomTheme, CustomDarkColors } from '@kit.ArkUI';

// ── Light palette ────────────────────────────────────────────────────────────
export class LightColors implements CustomColors {
  brand: ResourceColor             = '#FF0A59F7';
  fontPrimary: ResourceColor       = '#E5000000';
  fontSecondary: ResourceColor     = '#99000000';
  backgroundPrimary: ResourceColor = '#FFFFFFFF';
}

// Dark palette (AMOLED-optimised: pure black saves power on OLED)
export class DarkColors implements CustomColors {
  brand: ResourceColor             = '#FF317AF7';
  fontPrimary: ResourceColor       = '#E5FFFFFF';
  fontSecondary: ResourceColor     = '#99FFFFFF';
  backgroundPrimary: ResourceColor = '#FF000000'; // pure black → OLED pixels off
}

// Light theme (responds to system dark mode via darkColors)
export class LightTheme implements CustomTheme {
  colors: CustomColors     = new LightColors();
  darkColors: CustomDarkColors = new DarkColors(); // used when system switches to dark
}

// Dark theme (always dark, ignores system setting)
export class DarkTheme implements CustomTheme {
  colors: CustomColors = new DarkColors();
}

export const lightTheme: CustomTheme = new LightTheme();
export const darkTheme: CustomTheme  = new DarkTheme();
