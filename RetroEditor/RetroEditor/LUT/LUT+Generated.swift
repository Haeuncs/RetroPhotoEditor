// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif

// Deprecated typealiases
@available(*, deprecated, renamed: "ImageAsset.Image", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetImageTypeAlias = ImageAsset.Image

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
internal enum Asset {
  internal enum LUTPack {
    internal enum ContrastFilters {
      internal static let highContrast = ImageAsset(name: "LUT_pack/Contrast Filters/high_contrast")
      internal static let lowContrast = ImageAsset(name: "LUT_pack/Contrast Filters/low_contrast")
      internal static let mediumHighContrast = ImageAsset(name: "LUT_pack/Contrast Filters/medium_high_contrast")
      internal static let veryHighContrast = ImageAsset(name: "LUT_pack/Contrast Filters/very_high_contrast")
      internal static let veryLowContrast = ImageAsset(name: "LUT_pack/Contrast Filters/very_low_contrast")
    }
    internal enum FilmPresets {
      internal static let agfaAdvantix100 = ImageAsset(name: "LUT_pack/Film Presets/agfa_advantix_100")
      internal static let agfaAdvantix200 = ImageAsset(name: "LUT_pack/Film Presets/agfa_advantix_200")
      internal static let agfaAdvantix400 = ImageAsset(name: "LUT_pack/Film Presets/agfa_advantix_400")
      internal static let agfaAgfachromeCtPrecisa100 = ImageAsset(name: "LUT_pack/Film Presets/agfa_agfachrome_ct_precisa_100")
      internal static let agfaAgfachromeCtPrecisa200 = ImageAsset(name: "LUT_pack/Film Presets/agfa_agfachrome_ct_precisa_200")
      internal static let agfaAgfachromeRsx2050 = ImageAsset(name: "LUT_pack/Film Presets/agfa_agfachrome_rsx2_050")
      internal static let agfaAgfachromeRsx2100 = ImageAsset(name: "LUT_pack/Film Presets/agfa_agfachrome_rsx2_100")
      internal static let agfaAgfachromeRsx2200 = ImageAsset(name: "LUT_pack/Film Presets/agfa_agfachrome_rsx2_200")
      internal static let agfaAgfacolorFutura100Plus = ImageAsset(name: "LUT_pack/Film Presets/agfa_agfacolor_futura_100_plus")
      internal static let agfaAgfacolorFutura200Plus = ImageAsset(name: "LUT_pack/Film Presets/agfa_agfacolor_futura_200_plus")
      internal static let agfaAgfacolorFutura400Plus = ImageAsset(name: "LUT_pack/Film Presets/agfa_agfacolor_futura_400_plus")
      internal static let agfaAgfacolorFuturaIi100Plus = ImageAsset(name: "LUT_pack/Film Presets/agfa_agfacolor_futura_ii_100_plus")
      internal static let agfaAgfacolorFuturaIi200Plus = ImageAsset(name: "LUT_pack/Film Presets/agfa_agfacolor_futura_ii_200_plus")
      internal static let agfaAgfacolorFuturaIi400Plus = ImageAsset(name: "LUT_pack/Film Presets/agfa_agfacolor_futura_ii_400_plus")
      internal static let agfaAgfacolorHdc100Plus = ImageAsset(name: "LUT_pack/Film Presets/agfa_agfacolor_hdc_100_plus")
      internal static let agfaAgfacolorHdc200Plus = ImageAsset(name: "LUT_pack/Film Presets/agfa_agfacolor_hdc_200_plus")
      internal static let agfaAgfacolorHdc400Plus = ImageAsset(name: "LUT_pack/Film Presets/agfa_agfacolor_hdc_400_plus")
      internal static let agfaAgfacolorOptimaIi100 = ImageAsset(name: "LUT_pack/Film Presets/agfa_agfacolor_optima_ii_100")
      internal static let agfaAgfacolorOptimaIi200 = ImageAsset(name: "LUT_pack/Film Presets/agfa_agfacolor_optima_ii_200")
      internal static let agfaAgfacolorVista050 = ImageAsset(name: "LUT_pack/Film Presets/agfa_agfacolor_vista_050")
      internal static let agfaAgfacolorVista100 = ImageAsset(name: "LUT_pack/Film Presets/agfa_agfacolor_vista_100")
      internal static let agfaAgfacolorVista200 = ImageAsset(name: "LUT_pack/Film Presets/agfa_agfacolor_vista_200")
      internal static let agfaAgfacolorVista400 = ImageAsset(name: "LUT_pack/Film Presets/agfa_agfacolor_vista_400")
      internal static let agfaAgfacolorVista800 = ImageAsset(name: "LUT_pack/Film Presets/agfa_agfacolor_vista_800")
      internal static let eastmanDoubleXNeg12Min = ImageAsset(name: "LUT_pack/Film Presets/eastman_double_x_neg_12_min")
      internal static let eastmanDoubleXNeg4Min = ImageAsset(name: "LUT_pack/Film Presets/eastman_double_x_neg_4_min")
      internal static let eastmanDoubleXNeg5Min = ImageAsset(name: "LUT_pack/Film Presets/eastman_double_x_neg_5_min")
      internal static let eastmanDoubleXNeg6Min = ImageAsset(name: "LUT_pack/Film Presets/eastman_double_x_neg_6_min")
      internal static let fujifilmF125 = ImageAsset(name: "LUT_pack/Film Presets/fujifilm_f_125")
      internal static let fujifilmF250 = ImageAsset(name: "LUT_pack/Film Presets/fujifilm_f_250")
      internal static let fujifilmF400 = ImageAsset(name: "LUT_pack/Film Presets/fujifilm_f_400")
      internal static let fujifilmFci = ImageAsset(name: "LUT_pack/Film Presets/fujifilm_fci")
      internal static let fujifilmFp2900z = ImageAsset(name: "LUT_pack/Film Presets/fujifilm_fp2900z")
      internal static let kodakDscs3151 = ImageAsset(name: "LUT_pack/Film Presets/kodak_dscs_3151")
      internal static let kodakDscs3152 = ImageAsset(name: "LUT_pack/Film Presets/kodak_dscs_3152")
      internal static let kodakDscs3153 = ImageAsset(name: "LUT_pack/Film Presets/kodak_dscs_3153")
      internal static let kodakDscs3154 = ImageAsset(name: "LUT_pack/Film Presets/kodak_dscs_3154")
      internal static let kodakDscs3155 = ImageAsset(name: "LUT_pack/Film Presets/kodak_dscs_3155")
      internal static let kodakDscs3156 = ImageAsset(name: "LUT_pack/Film Presets/kodak_dscs_3156")
      internal static let kodakEktachrome100 = ImageAsset(name: "LUT_pack/Film Presets/kodak_ektachrome_100")
      internal static let kodakEktachrome100Plus = ImageAsset(name: "LUT_pack/Film Presets/kodak_ektachrome_100_plus")
      internal static let kodakEktachrome320t = ImageAsset(name: "LUT_pack/Film Presets/kodak_ektachrome_320t")
      internal static let kodakEktachrome400x = ImageAsset(name: "LUT_pack/Film Presets/kodak_ektachrome_400x")
      internal static let kodakEktachrome64 = ImageAsset(name: "LUT_pack/Film Presets/kodak_ektachrome_64")
      internal static let kodakEktachrome64t = ImageAsset(name: "LUT_pack/Film Presets/kodak_ektachrome_64t")
      internal static let kodakEktachromeE100s = ImageAsset(name: "LUT_pack/Film Presets/kodak_ektachrome_e100s")
      internal static let kodakGold100 = ImageAsset(name: "LUT_pack/Film Presets/kodak_gold_100")
      internal static let kodakGold200 = ImageAsset(name: "LUT_pack/Film Presets/kodak_gold_200")
      internal static let kodakKaf2001 = ImageAsset(name: "LUT_pack/Film Presets/kodak_kaf_2001")
      internal static let kodakKaf3000 = ImageAsset(name: "LUT_pack/Film Presets/kodak_kaf_3000")
      internal static let kodakKai0311 = ImageAsset(name: "LUT_pack/Film Presets/kodak_kai_0311")
      internal static let kodakKai0372 = ImageAsset(name: "LUT_pack/Film Presets/kodak_kai_0372")
      internal static let kodakKai1010 = ImageAsset(name: "LUT_pack/Film Presets/kodak_kai_1010")
      internal static let kodakKodachrome200 = ImageAsset(name: "LUT_pack/Film Presets/kodak_kodachrome_200")
      internal static let kodakKodachrome25 = ImageAsset(name: "LUT_pack/Film Presets/kodak_kodachrome_25")
      internal static let kodakKodachrome64 = ImageAsset(name: "LUT_pack/Film Presets/kodak_kodachrome_64")
      internal static let kodakMaxZoom800 = ImageAsset(name: "LUT_pack/Film Presets/kodak_max_zoom_800")
      internal static let kodakOptura981111 = ImageAsset(name: "LUT_pack/Film Presets/kodak_optura_981111")
      internal static let kodakOptura981111Slrr = ImageAsset(name: "LUT_pack/Film Presets/kodak_optura_981111_slrr")
      internal static let kodakOptura981113 = ImageAsset(name: "LUT_pack/Film Presets/kodak_optura_981113")
      internal static let kodakOptura981114 = ImageAsset(name: "LUT_pack/Film Presets/kodak_optura_981114")
      internal static let kodakPorta400nc = ImageAsset(name: "LUT_pack/Film Presets/kodak_porta_400nc")
      internal static let kodakPorta400vc = ImageAsset(name: "LUT_pack/Film Presets/kodak_porta_400vc")
      internal static let kodakPorta800 = ImageAsset(name: "LUT_pack/Film Presets/kodak_porta_800")
      internal static let kodakPortra100t = ImageAsset(name: "LUT_pack/Film Presets/kodak_portra_100t")
      internal static let kodakPortra160nc = ImageAsset(name: "LUT_pack/Film Presets/kodak_portra_160nc")
      internal static let kodakPortra160vc = ImageAsset(name: "LUT_pack/Film Presets/kodak_portra_160vc")
    }
    internal enum WebcamPresets {
      internal static let webcamPreset1 = ImageAsset(name: "LUT_pack/Webcam Presets/webcam_preset_1")
      internal static let webcamPreset2 = ImageAsset(name: "LUT_pack/Webcam Presets/webcam_preset_2")
      internal static let webcamPreset3 = ImageAsset(name: "LUT_pack/Webcam Presets/webcam_preset_3")
    }
    internal static let filmDefault = ImageAsset(name: "LUT_pack/film_default")
  }
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

internal struct ImageAsset {
  internal fileprivate(set) var name: String

  #if os(macOS)
  internal typealias Image = NSImage
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Image = UIImage
  #endif

  internal var image: Image {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    let name = NSImage.Name(self.name)
    let image = (bundle == .main) ? NSImage(named: name) : bundle.image(forResource: name)
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }
}

internal extension ImageAsset.Image {
  @available(macOS, deprecated,
    message: "This initializer is unsafe on macOS, please use the ImageAsset.image property")
  convenience init?(asset: ImageAsset) {
    #if os(iOS) || os(tvOS)
    let bundle = BundleToken.bundle
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
