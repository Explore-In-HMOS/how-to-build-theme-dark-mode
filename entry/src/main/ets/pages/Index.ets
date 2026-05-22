import { CustomTheme, ThemeControl } from '@kit.ArkUI';
import { lightTheme, darkTheme } from '../theme/AppThemes';
import { WatchFace } from '../components/WatchFace';
import { ControlPanel } from '../components/ControlPanel';

ThemeControl.setDefaultTheme(lightTheme);

@Entry
@Component
struct Index {
  @State private currentTheme: CustomTheme = lightTheme;
  @State private isDark: boolean = false;
  @State private isPrivacyMode: boolean = false;

  private toggleTheme(): void {
    this.isDark = !this.isDark;
    this.currentTheme = this.isDark ? darkTheme : lightTheme;
  }

  private togglePrivacy(): void {
    this.isPrivacyMode = !this.isPrivacyMode;
  }

  build() {
    // WithTheme scope: all children receive color tokens from currentTheme.
    // Updating currentTheme triggers automatic re-render — no manual updates needed.
    WithTheme({ theme: this.currentTheme }) {
      RelativeContainer() {
        WatchFace({ isPrivacyMode: this.isPrivacyMode })
          .id('watchface')
          .alignRules({
            top: { anchor: '__container__', align: VerticalAlign.Top },
            bottom: { anchor: '__container__', align: VerticalAlign.Bottom },
            left: { anchor: '__container__', align: HorizontalAlign.Start },
            right: { anchor: '__container__', align: HorizontalAlign.End }
          })

        ControlPanel({
          isDark: this.isDark,
          isPrivacyMode: this.isPrivacyMode,
          onThemeToggle: () => {
            this.toggleTheme();
          },
          onPrivacyToggle: () => {
            this.togglePrivacy();
          }
        })
          .id('panel')
          .alignRules({
            bottom: { anchor: '__container__', align: VerticalAlign.Bottom },
            left: { anchor: '__container__', align: HorizontalAlign.Start },
            right: { anchor: '__container__', align: HorizontalAlign.End }
          })
      }
      .width('100%')
      .height('100%')
    }
  }
}
