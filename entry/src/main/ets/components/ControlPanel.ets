// APIs demonstrated:
//   • Polymorphic Style (stateStyles) — theme toggle button states
//   • Opacity Control (.opacity)      — semi-transparent panel overlay
import {
  ArcButton,
  ArcButtonOptions,
  ArcButtonStyleMode,
  ArcButtonPosition,
  ColorMetrics,
  LengthMetrics,
  LengthUnit
} from '@kit.ArkUI';

@Component
export struct ControlPanel {
  @Prop isDark: boolean = false;
  @Prop isPrivacyMode: boolean = false;
  onThemeToggle: () => void = () => {
  };
  onPrivacyToggle: () => void = () => {
  };
  @State private isToggling: boolean = false;

  @Styles
  normalBtn() {
    .backgroundColor(this.isDark
      ? $r('app.color.btn_theme_normal_dark')
      : $r('app.color.btn_theme_normal'))
    .borderRadius(24)
    .width(148)
    .height(44)
    .opacity(1)
  }

  @Styles
  pressedBtn() {
    .backgroundColor(this.isDark
      ? $r('app.color.btn_theme_pressed_dark')
      : $r('app.color.btn_theme_pressed'))
    .borderRadius(24)
    .width(148)
    .height(44)
    .opacity(0.9)
  }

  @Styles
  disabledBtn() {
    .backgroundColor($r('app.color.btn_theme_disabled'))
    .borderRadius(24)
    .width(148)
    .height(44)
    .opacity(0.45)
  }

  build() {
    Column() {
      // Regular Button keeps stateStyles (Polymorphic Style API).
      // ArcButton does not expose stateStyles, so this is intentionally separate.
      Button(this.isDark
        ? $r('app.string.btn_light_mode')
        : $r('app.string.btn_dark_mode'))
        .fontSize(15)
        .fontWeight(FontWeight.Medium)
        .fontColor($r('app.color.btn_font_on_color'))
        .enabled(!this.isToggling)
        .stateStyles({
          normal: this.normalBtn,
          pressed: this.pressedBtn,
          disabled: this.disabledBtn
        })
        .onClick(() => {
          this.isToggling = true;
          this.onThemeToggle();
          setTimeout(() => {
            this.isToggling = false;
          }, 300);
        })
      // Privacy Toggle
      ArcButton({
        options: new ArcButtonOptions({
          label: this.isPrivacyMode
            ? $r('app.string.btn_privacy_off')
            : $r('app.string.btn_privacy_on'),
          position: ArcButtonPosition.BOTTOM_EDGE,
          styleMode: ArcButtonStyleMode.CUSTOM,
          backgroundColor: this.isPrivacyMode
            ? ColorMetrics.resourceColor($r('app.color.arc_btn_privacy_bg'))
            : ColorMetrics.resourceColor($r('app.color.arc_btn_privacy_inactive_bg')),
          fontColor: ColorMetrics.resourceColor($r('app.color.arc_btn_font')),
          fontSize: new LengthMetrics(15, LengthUnit.FP),
          onClick: () => {
            this.onPrivacyToggle();
          }
        })
      })
    }
    .width('100%')
    .alignItems(HorizontalAlign.Center)
    // Opacity Control: 0.85 makes the panel semi-transparent over the watch face.
    .opacity(0.85)
  }
}
