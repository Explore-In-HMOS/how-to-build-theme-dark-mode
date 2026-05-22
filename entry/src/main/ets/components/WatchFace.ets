import { Theme } from '@kit.ArkUI';

const PANEL_RESERVED_VP: number = 120;

@Component
export struct WatchFace {
  @Prop isPrivacyMode: boolean = false;
  @State private bgColor: ResourceColor = $r('app.color.app_bg_primary');
  @State private primaryColor: ResourceColor = $r('app.color.app_font_primary');
  @State private secondaryColor: ResourceColor = $r('app.color.app_font_secondary');

  onWillApplyTheme(theme: Theme): void {
    this.bgColor = theme.colors.backgroundPrimary;
    this.primaryColor = theme.colors.fontPrimary;
    this.secondaryColor = theme.colors.fontSecondary;
  }

  build() {
    Column() {
      // Clock numerals (custom WatchFont via @font-face)
      Text($r('app.string.label_clock'))
        .fontFamily('WatchFont')
        .fontSize(50)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.primaryColor)
        .letterSpacing(2)
        .margin({ top: 20 })
      Text($r('app.string.label_date'))
        .fontSize(15)
        .fontColor(this.secondaryColor)
        .margin({ top: 2 })

      Divider()
        .width(80)
        .strokeWidth(0.5)
        .color($r('app.color.watchface_divider'))
        .margin({ top: 2, bottom: 2 })
      // obscured() replaces content with a blur placeholder in Privacy Mode.
      // NOTE: explicit width + height are required for obscured() to render.
      Row({ space: 6 }) {
        Text('♥')
          .fontSize(14)
          .fontColor($r('app.color.heart_rate_icon'))
        Text($r('app.string.label_heart_rate'))
          .fontSize(14)
          .fontColor(this.secondaryColor)
          .width(110)
          .height(20)
          .obscured(this.isPrivacyMode ? [ObscuredReasons.PLACEHOLDER] : [])
      }
    }
    .width('100%')
    .height('100%')
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Center)
    .padding({ bottom: PANEL_RESERVED_VP })
    .backgroundColor(this.bgColor)
  }
}
