#import <UIKit/UIKit.h>
#import <Metal/Metal.h>
#import <MetalKit/MetalKit.h>
#import <Foundation/Foundation.h>
// ===== STATIC GLOBAL =====
static NSUserDefaults *saveSetting = nil;

// Forward declaration
static void SaveSettings(void);
bool BugSkillRange = true;

#include "Esp/dbdef.h"
#include "Esp/Includes.h"
#import "Esp/CaptainHook.h"
#import "Esp/ImGuiDrawView.h"

#import "imgui/imgui.h"
#import "imgui/imgui_impl_metal.h"
#import "imgui/fonts.h"
#import "imgui/imgui_internal.h"
#include "imgui/Fonts.hpp"

#import "imgui/img.h"
#import "imgui/stb_image.h"

#import "Image/Nmkios.h"
#import "NmkiOSVN/Dis.h"

#import "5Toubun/NakanoIchika.h"
#import "5Toubun/NakanoNino.h"
#import "5Toubun/NakanoMiku.h"
#import "5Toubun/NakanoItsuki.h"
#import "5Toubun/NakanoYotsuba.h"
#import "5Toubun/MonoString.h"
#import "5Toubun/dobby.h"
#import "5Toubun/patch.h"
#import "5Toubun/oxorany_include.h"

//ESP
#include "Unity/Quaternion.h"
#include "Unity/Vector2.h"
#import "Unity/Vector3.h"
#include "Unity/VInt3.h"
#include "Unity/EspManager.h"
#include "Unity/Monostring.h"

#import "fonts.h"
#import "stb_image.h"
#import "hook/hook.h"

#include <map>
#include <unordered_map>
#include <sys/syscall.h>
#include <mach-o/getsect.h>
#include <mach-o/loader.h>
#include <execinfo.h>
#include <thread>
#import <sys/utsname.h>


//#import "5Toubun/il2cpp.h"
//#import "imgui/Il2cpp.h"
//#import "5Toubun/AutoOffset.h"
//#import "OffsetUpdate.h"

//==================================
// Update Offset AOV VN / PoongHax
// Version : 1.61.1.1572693
// 21/01/2026 / 11:03:00
//==================================

//======== [ CreateString ] ==========
#define String_CreateStrings getRealOffset(ENCRYPTOFFSET("0x3977C40"))

//======== [ CameraSystem ] ==========
#define CameraSystem_GetZoomRate ENCRYPTOFFSET("0x664E340")
#define CameraSystem_Updates ENCRYPTOFFSET("0x664AC4C")
#define CameraSystem_OnCameraHeightChanged getRealOffset(ENCRYPTOFFSET("0x664C6A0"))
#define CameraSystem_zoomRateFromAge_Field ENCRYPTOFFSET("0x3C")

//======== [ UnityEngine Camera ] ==========
#define Camera_get_main getRealOffset(ENCRYPTOFFSET("0x6E2BBD4"))
#define Camera_WorldToViewportPoint2 getRealOffset(ENCRYPTOFFSET("0x6E2B078"))
#define Camera_WorldToScreenPoint getRealOffset(ENCRYPTOFFSET("0x6E2B324"))
#define Camera_WorldToViewportPoint1 getRealOffset(ENCRYPTOFFSET("0x6E2B394"))
#define Camera_get_fieldOfView getRealOffset(ENCRYPTOFFSET("0x6E2961C"))
#define Camera_set_fieldOfView getRealOffset(ENCRYPTOFFSET("0x6E2966C"))

//======== [ LVActorLinker ] ==========
#define LVActorLinker_SetVisible ENCRYPTOFFSET("0x44CAB6C")
#define LVActorLinker_ForceSetVisible ENCRYPTOFFSET("0x44CAE84")
#define LVActorLinker_SyncActiveView ENCRYPTOFFSET("0x44C6C30")

//======== [ Unlock Skin ] ==========
#define UL_IsSkinAvailable ENCRYPTOFFSET("0x5929E10")
#define UL_RefreshHeroPanel getRealOffset(ENCRYPTOFFSET("0x4C263B0"))
#define UL_unpackSkin ENCRYPTOFFSET("0x9FC05C")
#define UL_IsCanUseSkin ENCRYPTOFFSET("0x52A4FC0")
#define UL_OnClickSelectHeroSkin ENCRYPTOFFSET("0x4C34C14")
#define UL_IsHaveHeroSkin ENCRYPTOFFSET("0x52A4198")
#define UL_GetHeroWearSkinId ENCRYPTOFFSET("0x52B5AB4")
#define dwHeroID_Field ENCRYPTOFFSET("0x8")
#define wSkinID_Field ENCRYPTOFFSET("0x3A")

#define Evo_IsAwakeSkin ENCRYPTOFFSET("0x688FE70")
#define Evo_GetAwakeSkinData getRealOffset(ENCRYPTOFFSET("0x6890070"))
#define Evo_Data_bWakeLevel ENCRYPTOFFSET("0x20")
#define Evo_Data_ullWakeFeatureMask ENCRYPTOFFSET("0x28")
#define Evo_Data_bCurWearLevel ENCRYPTOFFSET("0x30")
#define Evo_Data_ullWearFeatureMask ENCRYPTOFFSET("0x38")
#define Evo_unpack ENCRYPTOFFSET("0xC5D7C8")
#define unpack_bSkinWakeLevel ENCRYPTOFFSET("0xC0")
#define unpack_ullSkinWakeFeatureMask ENCRYPTOFFSET("0xC8")

//======== [ PlayerBase ] ==========
#define H_PlayerId ENCRYPTOFFSET("0x8")
#define H_PlayerUId ENCRYPTOFFSET("0x18")
#define H_broadcastID ENCRYPTOFFSET("0xFC")
#define H_PersonalButtonID ENCRYPTOFFSET("0x104")
#define H_usingSoldierSkinID ENCRYPTOFFSET("0x128")

//======== [ ESP ] ==========
#define Esp_LActorRoot_get_ObjID getRealOffset(ENCRYPTOFFSET("0x448E248"))
#define Esp_LActorRoot_GiveMyEnemyCamp getRealOffset(ENCRYPTOFFSET("0x44AA2C8"))
#define Esp_LActorRoot_AsHero getRealOffset(ENCRYPTOFFSET("0x44AA54C"))
#define Esp_LActorRoot_get_PlayerMovement getRealOffset(ENCRYPTOFFSET("0x44A2EC4"))
#define Esp_LActorRoot_get_forward getRealOffset(ENCRYPTOFFSET("0x4491950"))
#define Esp_LActorRoot_get_location getRealOffset(ENCRYPTOFFSET("0x4490184"))
#define Esp_LActorRoot_AsOrgan getRealOffset(ENCRYPTOFFSET("0x44AA474"))
#define Esp_LActorRoot_IsOwner getRealOffset(ENCRYPTOFFSET("0x44AA240"))
#define Esp_LOrganWrapper_get_isTower getRealOffset(ENCRYPTOFFSET("0x44443C0"))
#define Esp_ActorLinker_AsHero getRealOffset(ENCRYPTOFFSET("0x6406F20"))
#define Esp_ActorLinker_get_ObjID getRealOffset(ENCRYPTOFFSET("0x63FCCF8"))
#define Esp_ActorLinker_IsHostPlayer getRealOffset(ENCRYPTOFFSET("0x6407234"))
#define Esp_ActorLinker_get_objType getRealOffset(ENCRYPTOFFSET("0x63FD9C4"))
#define Esp_ActorLinker_get_objCamp getRealOffset(ENCRYPTOFFSET("0x63FD964"))
#define Esp_ActorLinker_get_position getRealOffset(ENCRYPTOFFSET("0x63FD4C4"))
#define Esp_ActorLinker_get_bVisible getRealOffset(ENCRYPTOFFSET("0x63FD810"))
#define Esp_ActorLinker_get_ConfigId getRealOffset(ENCRYPTOFFSET("0x63FD904"))
#define Esp_LObjWrapper_get_IsDeadState getRealOffset(ENCRYPTOFFSET("0x4419C48"))
#define Esp_PlayerMovement_get_speed getRealOffset(ENCRYPTOFFSET("0x43D371C"))
#define Esp_ValueLinkerComponent_get_actorHp getRealOffset(ENCRYPTOFFSET("0x643395C"))
#define Esp_ValueLinkerComponent_get_actorHpTotal getRealOffset(ENCRYPTOFFSET("0x643396C"))
#define Esp_ValueLinkerComponent_get_actorSoulLever getRealOffset(ENCRYPTOFFSET("0x64339BC"))
#define Esp_ValuePropertyComponent_get_actorHp getRealOffset(ENCRYPTOFFSET("0x43D7EB4"))
#define Esp_ValuePropertyComponent_set_actorHp getRealOffset(ENCRYPTOFFSET("0x43D7F2C"))
#define Esp_ValuePropertyComponent_get_actorHpTotal getRealOffset(ENCRYPTOFFSET("0x43D8678"))
#define Esp_ValuePropertyComponent_get_actorEp getRealOffset(ENCRYPTOFFSET("0x43D89C4"))
#define Esp_ValuePropertyComponent_get_actorEpTotal getRealOffset(ENCRYPTOFFSET("0x43D8AC0"))
#define Esp_ValuePropertyComponent_get_actorSoulLevel getRealOffset(ENCRYPTOFFSET("0x43D8C74"))

//======== [ PhÃ¡Â»Â¥ ] ==========
#define SkillSlot_RequestUseSkill getRealOffset(ENCRYPTOFFSET("0x5AD9F90"))
#define SkillSlot_ReadyUseSkill getRealOffset(ENCRYPTOFFSET("0x5AD9D20"))
#define CSkillButtonManager_ReadyUseSkill getRealOffset(ENCRYPTOFFSET("0x5146034"))
#define CSkillButtonManager_get_IsCharging getRealOffset(ENCRYPTOFFSET("0x51317AC"))
#define CSkillButtonManager_RequestUseSkillSlot getRealOffset(ENCRYPTOFFSET("0x513FFB8"))
#define KyriosFramework_get_hostLogic getRealOffset(ENCRYPTOFFSET("0x62BC360"))
#define KyriosFramework_get_playerCenter getRealOffset(ENCRYPTOFFSET("0x62BD564"))
#define KyriosFramework_get_actorManager getRealOffset(ENCRYPTOFFSET("0x62BC428"))
#define Esp_LActorRoot_ActorControl ENCRYPTOFFSET("0x2D8")
#define Esp_LActorRoot_ValueComponent ENCRYPTOFFSET("0x308")
#define Esp_ActorLinker_HudControl ENCRYPTOFFSET("0x70")
#define Esp_ActorLinker_ValueComponent ENCRYPTOFFSET("0x28")
#define Skil_SkillSlot_SlotType ENCRYPTOFFSET("0x80")
#define Skil_SkillSlot_skillIndicator ENCRYPTOFFSET("0xB8")
#define Skil_SkillControlIndicator_curindicatorDistance ENCRYPTOFFSET("0x170")
#define SkillControlIndicator_useSkillDirection ENCRYPTOFFSET("0x38")
#define SkillControlIndicator_LateUpdate ENCRYPTOFFSET("0x5AC0638")
#define CD_heroWrapSkillData_ex3 ENCRYPTOFFSET("0xC0")
#define CD_heroWrapSkillData_5 ENCRYPTOFFSET("0xA0")
#define CD_heroWrapSkillData_2 ENCRYPTOFFSET("0x40")
#define CD_heroWrapSkillData_3 ENCRYPTOFFSET("0x60")
#define CD_heroWrapSkillData_4 ENCRYPTOFFSET("0x80")
#define CD_m_commonSkillID ENCRYPTOFFSET("0xF8")

//======== [ HOOK ] ==========
#define CPlayerProfile_get_IsHostProfile ENCRYPTOFFSET("0x4CB8F00")
#define RelaySvrConnector_Disconnect ENCRYPTOFFSET("0x5995478")
#define LFramework_EndGame ENCRYPTOFFSET("0x48579D0")
#define PersonalButton_IsOpen ENCRYPTOFFSET("0x5124A38")
#define PersonalButton_get_PersonalBtnId ENCRYPTOFFSET("0x512544C")
#define HeroInfoPanel_ShowHeroInfo ENCRYPTOFFSET("0x50B4EDC")
#define MiniMapHeroInfo_ShowSkillStateInfo ENCRYPTOFFSET("0x5ECEEFC")
#define MiniMapHeroInfo_ShowHeroHpInfo ENCRYPTOFFSET("0x5ECED98")
#define CUIUtility_RemoveSpace ENCRYPTOFFSET("0x571B468")
#define Utility_CheckRoleName ENCRYPTOFFSET("0x4B58594")
#define InBattleMsgNetCore_SendInBattleMsg_InputChat ENCRYPTOFFSET("0x50C16E0")
#define CItem_get_IsCanSell ENCRYPTOFFSET("0x53122E4")
#define SkillControlIndicator_GetUseSkillDirection ENCRYPTOFFSET("0x5ABA858")
#define HeroSelectBanPickWindow_InitTeamHeroList ENCRYPTOFFSET("0x4BBF550")
#define CMatchingSystem_checkTeamLaderGradeMax ENCRYPTOFFSET("0x4D2FF48")
#define HudComponent3D_SetPlayerName ENCRYPTOFFSET("0x5B50F78")
#define SkillSlot_LateUpdate ENCRYPTOFFSET("0x5AD8FAC")
#define CSkillButtonManager_LateUpdate ENCRYPTOFFSET("0x514863C")
#define adr_LActorRoot_UpdateLogic ENCRYPTOFFSET("0x44A99C0")
#define ActorLinker_DestroyActor ENCRYPTOFFSET("0x64031C4")
#define LActorRoot_DestroyActor ENCRYPTOFFSET("0x44A9184")
#define adr_ActorLinker_Update ENCRYPTOFFSET("0x640356C")
#define GameSettings_get_Supported60FPSMode ENCRYPTOFFSET("0x58E20A4")
#define GameSettings_get_Supported90FPSMode ENCRYPTOFFSET("0x58CCABC")
#define GameSettings_get_Supported120FPSMode ENCRYPTOFFSET("0x58CC9E4")
#define BattleStatistic_CreateHeroData ENCRYPTOFFSET("0x429C53C")
#define PVPLoadingView_OnEnter ENCRYPTOFFSET("0x52FEB20")

#define PVPLoadingView_ShowRank ENCRYPTOFFSET("0x52FFE40")
#define HeroItem_updateTalentSkillCD ENCRYPTOFFSET("0x5069478")


#define timer(sec) dispatch_after(dispatch_time(DISPATCH_TIME_NOW, sec * NSEC_PER_SEC), dispatch_get_main_queue(), ^
#define iPhonePlus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)
#define kWidth  [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height
#define kScale [UIScreen mainScreen].scale
//using namespace Il2CppUtils;
@interface ImGuiDrawView () <MTKViewDelegate>
@property (nonatomic, strong) id <MTLDevice> device;
@property (nonatomic, strong) id <MTLCommandQueue> commandQueue;
@end

@implementation ImGuiDrawView

// ===== GLOBAL =====

// ===== LOAD SETTINGS =====
 void LoadSettings(void) {

    if ([saveSetting objectForKey:@"HackMap"] == nil) {

        HackMap = false;
        ShowUlti = false;
        ShowCD = false;
        StreamerMode = false;
        unlockskin = false;

        selectedbutton = 0;
        selectedValue2 = 0;

        OnCamera = false;
        AimSkill = false;
        aimType = 0;
        drawType = 2;

        ShowLsd = false;
        ShowLockName = false;
        ShowAvatar = false;

        spamchat = false;
        solanchat = 1;

        ShowBoTroz = false;
        ShowRank = false;
        Bantuido = false;

        ChapToAOV = 0;
        TopSelected = 0;
        selectedRank = 0;

        Mod_Rank = false;
        enableTopSelect = false;
        selectedStar = 0;
        SkinLinh = 0;

        BugSkillRange = false;
        Unlock120fps = false;

        autobocpha = false;
        bangsuongz = false;
        capcuuz = false;
        hoimau = false;

        mauphutro = 13.79f;
        maubotro  = 12.67f;
        mauhoimau = 16.2f;
        maucapcuu = 18.45f;

        SetFieldOfView = 0.0f;

        SaveSettings();
        return;
    }

    HackMap = [saveSetting boolForKey:@"HackMap"];
    ShowUlti = [saveSetting boolForKey:@"ShowUlti"];
    ShowCD = [saveSetting boolForKey:@"ShowCD"];
    StreamerMode = [saveSetting boolForKey:@"StreamerMode"];
    unlockskin = [saveSetting boolForKey:@"unlockskin"];

    selectedbutton = [saveSetting integerForKey:@"selectedbutton"];
    selectedValue2 = [saveSetting integerForKey:@"selectedValue2"];

    OnCamera = [saveSetting boolForKey:@"OnCamera"];
    AimSkill = [saveSetting boolForKey:@"AimSkill"];
    aimType = [saveSetting integerForKey:@"aimType"];
    drawType = [saveSetting integerForKey:@"drawType"];

    ShowLsd = [saveSetting boolForKey:@"ShowLsd"];
    ShowLockName = [saveSetting boolForKey:@"ShowLockName"];
    ShowAvatar = [saveSetting boolForKey:@"ShowAvatar"];

    spamchat = [saveSetting boolForKey:@"spamchat"];
    solanchat = [saveSetting integerForKey:@"solanchat"];

    ShowBoTroz = [saveSetting boolForKey:@"ShowBoTroz"];
    ShowRank = [saveSetting boolForKey:@"ShowRank"];
    Bantuido = [saveSetting boolForKey:@"Bantuido"];

    ChapToAOV = [saveSetting integerForKey:@"ChapToAOV"];
    TopSelected = [saveSetting integerForKey:@"TopSelected"];
    selectedRank = [saveSetting integerForKey:@"selectedRank"];

    Mod_Rank = [saveSetting boolForKey:@"Mod_Rank"];
    enableTopSelect = [saveSetting boolForKey:@"enableTopSelect"];
    selectedStar = [saveSetting integerForKey:@"selectedStar"];
    SkinLinh = [saveSetting integerForKey:@"SkinLinh"];

    BugSkillRange = [saveSetting boolForKey:@"BugSkillRange"];
    Unlock120fps = [saveSetting boolForKey:@"Unlock120fps"];

    autobocpha = [saveSetting boolForKey:@"autobocpha"];
    bangsuongz = [saveSetting boolForKey:@"bangsuongz"];
    capcuuz = [saveSetting boolForKey:@"capcuuz"];
    hoimau = [saveSetting boolForKey:@"hoimau"];

    maubotro = [saveSetting floatForKey:@"maubotro"];
    mauphutro = [saveSetting floatForKey:@"mauphutro"];
    mauhoimau = [saveSetting floatForKey:@"mauhoimau"];
    maucapcuu = [saveSetting floatForKey:@"maucapcuu"];

    SetFieldOfView = [saveSetting floatForKey:@"SetFieldOfView"];
}

// ===== SAVE SETTINGS =====
static void SaveSettings(void) {

    [saveSetting setBool:HackMap forKey:@"HackMap"];
    [saveSetting setBool:ShowUlti forKey:@"ShowUlti"];
    [saveSetting setBool:ShowCD forKey:@"ShowCD"];
    [saveSetting setBool:StreamerMode forKey:@"StreamerMode"];
    [saveSetting setBool:unlockskin forKey:@"unlockskin"];

    [saveSetting setInteger:selectedbutton forKey:@"selectedbutton"];
    [saveSetting setInteger:selectedValue2 forKey:@"selectedValue2"];

    [saveSetting setBool:OnCamera forKey:@"OnCamera"];
    [saveSetting setBool:AimSkill forKey:@"AimSkill"];
    [saveSetting setInteger:aimType forKey:@"aimType"];
    [saveSetting setInteger:drawType forKey:@"drawType"];

    [saveSetting setBool:ShowLsd forKey:@"ShowLsd"];
    [saveSetting setBool:ShowLockName forKey:@"ShowLockName"];
    [saveSetting setBool:ShowAvatar forKey:@"ShowAvatar"];

    [saveSetting setBool:spamchat forKey:@"spamchat"];
    [saveSetting setInteger:solanchat forKey:@"solanchat"];

    [saveSetting setBool:ShowBoTroz forKey:@"ShowBoTroz"];
    [saveSetting setBool:ShowRank forKey:@"ShowRank"];
    [saveSetting setBool:Bantuido forKey:@"Bantuido"];

    [saveSetting setInteger:ChapToAOV forKey:@"ChapToAOV"];
    [saveSetting setInteger:TopSelected forKey:@"TopSelected"];
    [saveSetting setInteger:selectedRank forKey:@"selectedRank"];

    [saveSetting setBool:Mod_Rank forKey:@"Mod_Rank"];
    [saveSetting setBool:enableTopSelect forKey:@"enableTopSelect"];
    [saveSetting setInteger:selectedStar forKey:@"selectedStar"];
    [saveSetting setInteger:SkinLinh forKey:@"SkinLinh"];

    [saveSetting setBool:BugSkillRange forKey:@"BugSkillRange"];
    [saveSetting setBool:Unlock120fps forKey:@"Unlock120fps"];

    [saveSetting setBool:autobocpha forKey:@"autobocpha"];
    [saveSetting setBool:bangsuongz forKey:@"bangsuongz"];
    [saveSetting setBool:capcuuz forKey:@"capcuuz"];
    [saveSetting setBool:hoimau forKey:@"hoimau"];

    [saveSetting setFloat:maubotro forKey:@"maubotro"];
    [saveSetting setFloat:mauphutro forKey:@"mauphutro"];
    [saveSetting setFloat:mauhoimau forKey:@"mauhoimau"];
    [saveSetting setFloat:maucapcuu forKey:@"maucapcuu"];

    [saveSetting setFloat:SetFieldOfView forKey:@"SetFieldOfView"];

    [saveSetting synchronize];
}

static int tab = 1;
static float SetFieldOfView = 0.0f;
static bool show_s0 = false;
static bool MenDeal = true;

static bool ShowBoTroz = false;
static bool ShowRank = false;
static bool ShowBoTroz_active = false;
static bool ShowRank_active = false;


bool ESPEnable = false;
bool CheckFogEsp = false;
bool PlayerDistance = false;
bool EspLine = false;
bool ESPBox = false;
bool ESP_HP = false;

ImFont* FontThemes;
ImFont* xFontPongs;


id<MTLTexture> LoadImageFromMemory(id<MTLDevice> device, unsigned char* image_data, size_t image_size) {
    CFDataRef imageData = CFDataCreate(kCFAllocatorDefault, image_data, image_size);
    CGDataProviderRef dataProvider = CGDataProviderCreateWithCFData(imageData);
    CGImageRef cgImage = CGImageCreateWithPNGDataProvider(dataProvider, NULL, false, kCGRenderingIntentDefault);
    CFRelease(imageData);
    CGDataProviderRelease(dataProvider);
    if (!cgImage) {
        return nil;
    }
    NSError *error = nil;
    MTKTextureLoader *textureLoader = [[MTKTextureLoader alloc] initWithDevice:device];
    NSDictionary *options = @{MTKTextureLoaderOptionSRGB : @(NO)};
    id<MTLTexture> texture = [textureLoader newTextureWithCGImage:cgImage options:options error:&error];

    if (error) {
        CGImageRelease(cgImage);
        return nil;
    }
    CGImageRelease(cgImage);
    return texture;
}


- (instancetype)initWithNibName:(nullable NSString *)nibNameOrNil bundle:(nullable NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

    _device = MTLCreateSystemDefaultDevice();
    _commandQueue = [_device newCommandQueue];

    if (!self.device) abort();

    IMGUI_CHECKVERSION();
    ImGui::CreateContext();
    ImGuiIO& io = ImGui::GetIO(); (void)io;

    ImGuiStyle& style = ImGui::GetStyle();

    ImFontConfig config;
    config.FontDataOwnedByAtlas = false;
    
    io.Fonts->Clear();

    ImFontConfig font_cfg;
    font_cfg.FontDataOwnedByAtlas = false;

    ImGui::StyleColorsDark();
    
    ImFont* font = io.Fonts->AddFontFromMemoryCompressedTTF((void*)zzz_compressed_data, zzz_compressed_size, 16.0f, NULL, io.Fonts->GetGlyphRangesVietnamese());
    
    static const ImWchar icons_ranges[] = { ICON_MIN_FA, ICON_MAX_FA, 0 };
    ImFontConfig icons_config;
    icons_config.MergeMode = true;
    icons_config.PixelSnapH = true;
    icons_config.FontDataOwnedByAtlas = false;

    io.Fonts->AddFontFromMemoryTTF((void*)fontAwesome, sizeof(fontAwesome), 16.0f, &icons_config, icons_ranges);

    FontThemes = io.Fonts->AddFontFromMemoryTTF(TtftoHex_Craftedby_Devx, sizeof(TtftoHex_Craftedby_Devx), 16.0f);

    ImGui_ImplMetal_Init(_device);

    return self;
}

+ (void)showChange:(BOOL)open
{
    MenDeal = open;
}

+ (BOOL)isMenuShowing {
    return MenDeal;
}

- (MTKView *)mtkView
{
    return (MTKView *)self.view;
}

- (void)loadView
{
    CGFloat w = [UIApplication sharedApplication].windows[0].rootViewController.view.frame.size.width;
    CGFloat h = [UIApplication sharedApplication].windows[0].rootViewController.view.frame.size.height;
    self.view = [[MTKView alloc] initWithFrame:CGRectMake(0, 0, w, h)];
}

bool CustomCheckbox(const char* label, bool* v)
{
    ImGui::PushID(label);

    // --- 1. FORM DÁNG SIÊU MỀM (SQUIRCLE) ---
    // Padding 9 -> Ô to, dễ bấm
    ImGui::PushStyleVar(ImGuiStyleVar_FramePadding, ImVec2(9.0f, 9.0f)); 
    
    // 🔥 QUAN TRỌNG: Bo tròn 12px -> Tạo hình vuông bầu cực đẹp (kiểu iOS)
    // Nếu muốn tròn vo như hình tròn luôn thì tăng lên 20.0f
    ImGui::PushStyleVar(ImGuiStyleVar_FrameRounding, 12.0f); 
    
    // Khoảng cách chữ và ô -> Thoáng
    ImGui::PushStyleVar(ImGuiStyleVar_ItemInnerSpacing, ImVec2(12.0f, 0)); 
    // Viền 1px -> Giữ nét sắc sảo
    ImGui::PushStyleVar(ImGuiStyleVar_FrameBorderSize, 1.0f);           

    // --- 2. MÀU SẮC (GIỮ NGUYÊN THEO YÊU CẦU) ---
    ImVec4 textOn   = ImVec4(0.95f, 0.95f, 0.95f, 1.0f);
    ImVec4 textOff  = ImVec4(0.55f, 0.55f, 0.55f, 1.0f);
    ImVec4 checkOn  = ImVec4(0.85f, 0.20f, 0.20f, 1.0f); // Đỏ

    ImVec4 bgIdle   = ImVec4(0.18f, 0.18f, 0.18f, 1.0f);
    ImVec4 bgHover  = ImVec4(0.22f, 0.22f, 0.22f, 1.0f);
    ImVec4 bgActive = ImVec4(0.25f, 0.25f, 0.25f, 1.0f);
    ImVec4 border   = ImVec4(0.28f, 0.28f, 0.28f, 1.0f); 

    ImGui::PushStyleColor(ImGuiCol_Text, *v ? textOn : textOff);
    ImGui::PushStyleColor(ImGuiCol_CheckMark, checkOn);
    ImGui::PushStyleColor(ImGuiCol_FrameBg, bgIdle);
    ImGui::PushStyleColor(ImGuiCol_FrameBgHovered, bgHover);
    ImGui::PushStyleColor(ImGuiCol_FrameBgActive, bgActive);
    ImGui::PushStyleColor(ImGuiCol_Border, border);

    // --- 3. RENDER ---
    bool changed = ImGui::Checkbox(label, v);

    // --- 4. CLEANUP ---
    ImGui::PopStyleColor(6);
    ImGui::PopStyleVar(4);
    ImGui::PopID();

    ImGui::Dummy(ImVec2(0, 5.0f)); // Khoảng cách dọc to hơn chút cho thoáng
    return changed;
}

bool MenuButton(const char* label, bool active)
{
    ImVec2 size = ImVec2(100, 26); // 👈 GIẢM MẠNH WIDTH + HEIGHT

    ImVec4 bgActive     = ImVec4(0.75f, 0.15f, 0.15f, 1.0f);
    ImVec4 bgInactive   = ImVec4(0.16f, 0.16f, 0.16f, 1.0f);
    ImVec4 bgHover      = ImVec4(0.85f, 0.20f, 0.20f, 1.0f);
    ImVec4 textActive   = ImVec4(1,1,1,1);
    ImVec4 textInactive = ImVec4(0.65f,0.65f,0.65f,1);
    ImVec4 barColor     = ImVec4(0.9f,0.25f,0.25f,1);

    ImGui::PushStyleVar(ImGuiStyleVar_FrameRounding, 5);        // 👈 bo nhỏ lại
    ImGui::PushStyleVar(ImGuiStyleVar_FramePadding, ImVec2(5, 3)); // 👈 PADDING NHỎ

    ImGui::PushStyleColor(ImGuiCol_Button, active ? bgActive : bgInactive);
    ImGui::PushStyleColor(ImGuiCol_ButtonHovered, bgHover);
    ImGui::PushStyleColor(ImGuiCol_ButtonActive, bgActive);
    ImGui::PushStyleColor(ImGuiCol_Text, active ? textActive : textInactive);

    bool clicked = ImGui::Button(label, size);

    ImGui::PopStyleColor(4);
    ImGui::PopStyleVar(2);

    if (active)
    {
        ImVec2 min = ImGui::GetItemRectMin();
        ImVec2 max = ImGui::GetItemRectMax();
        ImGui::GetWindowDrawList()->AddRectFilled(
            ImVec2(min.x + 8, max.y - 3),
            ImVec2(max.x - 8, max.y - 1),
            ImGui::GetColorU32(barColor),
            2.0f
        );
    }

    return clicked;
}

bool MenuButton(const char* label, bool active,
                ImVec4, ImVec4, ImVec4)
{
    return MenuButton(label, active);
}

static void HelpMarker(const char* desc)
{
ImGui::TextDisabled(""); 
if (ImGui::IsItemHovered())
{
ImGui::BeginTooltip();
ImGui::PushTextWrapPos(ImGui::GetFontSize() * 35.0f);
ImGui::TextUnformatted(desc) ;
ImGui::PopTextWrapPos();
ImGui::EndTooltip();
}
}

struct HookTask {
    int type;              // 1 = hook, 0 = patch
    uint64_t offset;
    void *arg1;
    void *arg2;
};

static std::vector<HookTask> gHighQ; // hook
static std::vector<HookTask> gLowQ;  // patch

static std::atomic<bool> gRunning(false);

#pragma mark - Time utils

static inline uint64_t NanoTime() {
    static mach_timebase_info_data_t info;
    if (info.denom == 0) mach_timebase_info(&info);
    return mach_absolute_time() * info.numer / info.denom;
}

#pragma mark - Hook impl (GIỮ NGUYÊN)

static inline void HOOK_IMPL(uint64_t off, void *newFunc, void **oldFunc) {

    NSString *ret = Hook1110(
        "Frameworks/UnityFramework.framework/UnityFramework",
        off,
        nullptr
    );
    if (!ret) return;

    void *orig = StaticInlineHookFunction(
        "Frameworks/UnityFramework.framework/UnityFramework",
        off,
        newFunc
    );

    if (oldFunc)
        *oldFunc = orig;
}

#pragma mark - Ultra Smooth Batch Runner

static void RunHookBatch() {

    if (gHighQ.empty() && gLowQ.empty()) {
        gRunning = false;
        return;
    }

    // ===== TIME BUDGET (ns) =====
    const uint64_t FRAME_BUDGET =
    (gHighQ.size() + gLowQ.size() > 200)
    ? 1500000   // 1.5 ms
    : 2500000;  // 2.5 ms
    // ============================

    uint64_t start = NanoTime();

    while (NanoTime() - start < FRAME_BUDGET) {

        HookTask t;
        bool hasTask = false;

        if (!gHighQ.empty()) {
            t = gHighQ.back();
            gHighQ.pop_back();
            hasTask = true;
        }
        else if (!gLowQ.empty()) {
            t = gLowQ.back();
            gLowQ.pop_back();
            hasTask = true;
        }

        if (!hasTask) break;

        if (t.type == 1) {
            HOOK_IMPL(t.offset, t.arg1, (void **)t.arg2);
        } else {
            Hook1110(
                (char *)t.arg1,
                t.offset,
                (char *)t.arg2
            );
        }
    }

    // ==== schedule next tick ====
    dispatch_after(
        dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.010 * NSEC_PER_SEC)),
        dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0),
        ^{
            RunHookBatch();
        }
    );
}

#pragma mark - Push API (KHÔNG ĐỔI CÁCH DÙNG)

static inline void PushHook(uint64_t off, void *newFunc, void *oldFuncAddr) {

    gHighQ.push_back({1, off, newFunc, oldFuncAddr});

    if (!gRunning.exchange(true)) {
        RunHookBatch();
    }
}

static inline void PushPatch(char *image, uint64_t off, char *hex) {

    gLowQ.push_back({0, off, image, hex});

    if (!gRunning.exchange(true)) {
        RunHookBatch();
    }
}

#pragma mark - Macro (GIỮ NGUYÊN)

#define HookPatch(offset, newFunc, oldFunc) \
    PushHook((uint64_t)(offset), (void *)(newFunc), (void *)(&(oldFunc)))

#define PatchOffset(img, offset, hex) \
    PushPatch((char *)(img), (uint64_t)(offset), (char *)(hex))

class Camera {
	public:
        static Camera *get_main() {
        Camera *(*get_main_) () = (Camera *(*)()) Camera_get_main;  /*GetMethodOffset("UnityEngine.CoreModule.dll", "UnityEngine", "Camera", "get_main", 0);*/
        
        return get_main_();
    }

    Vector3 WorldToViewportPoint(Vector3 position) 
    {
    Vector3 (*WorldToViewportPoint_)(Camera* camera, Vector3 position) = (Vector3 (*)(Camera*, Vector3)) Camera_WorldToViewportPoint2; /*GetMethodOffset(oxorany("UnityEngine.CoreModule.dll"), oxorany("UnityEngine"), oxorany("Camera"), oxorany("WorldToViewportPoint"), 2);*/
    return WorldToViewportPoint_(this, position);
    }
    
    Vector3 WorldToScreenPoint(Vector3 position) {
        Vector3 (*WorldToScreenPoint_)(Camera *camera, Vector3 position) = (Vector3 (*)(Camera *, Vector3)) Camera_WorldToScreenPoint; //GetMethodOffset("UnityEngine.CoreModule.dll", "UnityEngine", "Camera", "WorldToScreenPoint", 1);
        
        return WorldToScreenPoint_(this, position);
    }

    Vector3 WorldToScreen(Vector3 position) {
        Vector3 (*WorldToViewportPoint_)(Camera* camera, Vector3 position, int eye) = (Vector3 (*)(Camera*, Vector3, int)) Camera_WorldToViewportPoint1; //GetMethodOffset("UnityEngine.CoreModule.dll", "UnityEngine", "Camera", "WorldToViewportPoint", 1);
        
        return WorldToViewportPoint_(this, position, 2);
}
};


ImDrawList* getDrawList(){
    ImDrawList *drawList;
    drawList = ImGui::GetBackgroundDrawList();
    return drawList;
};

struct EntityInfo {
    Vector3 myPos;
    Vector3 enemyPos;
    Vector3 moveForward;
    int ConfigID;
    bool isMoving;
    int currentSpeed;
    float bullettime;
    float Ranger;
    int Hud;
    int Hudh;
    int Level; 
   // ActorLinker *Entity;
};

EntityInfo EnemyTarget;



int (*LActorRoot_get_ObjID)(void *instance);
int (*ActorLinker_get_ObjID)(void *instance);
int (*ActorLinker_COM_PLAYERCAMP)(void *instance);
int (*LActorRoot_COM_PLAYERCAMP)(void *instance);
bool (*ActorLinker_IsHostPlayer)(void *instance);
int (*ActorLinker_ActorTypeDef)(void *instance);
Vector3 (*ActorLinker_getPosition)(void *instance);
bool (*ActorLinker_get_bVisible)(void *instance);
void* (*LActorRoot_LHeroWrapper)(void *instance);
bool (*LObjWrapper_get_IsDeadState)(void *instance);
void* (*LActorRoot_get_PlayerMovement)(void* instance);
int (*get_speed)(void* instance);
int (*ActorLinker_ConfigId)(void* instance);


VInt3 (*LActorRoot_get_location)(void *instance);
VInt3 (*LActorRoot_get_forward)(void *instance);

int (*ValuePropertyComponent_get_actorHp)(void *instance);
int (*ValuePropertyComponent_get_actorHpTotal)(void *instance);
int (*ValuePropertyComponent_get_actorSoulLevel)(void *instance);
int (*ValuePropertyComponent_get_actorEp)(void *instance);
int (*ValuePropertyComponent_get_actorEpTotal)(void *instance);

int (*GetCurSkillSlotType)(void *instance);
bool (*get_IsCharging)(void *instance);
bool (*RequestUseSkillSlot)(void *instance, int slot, int mode, uint objID, int subSkillID);

int (*ValueLinkerComponent_get_actorHp)(void *instance);
int (*ValueLinkerComponent_get_actorHpTotal)(void *instance);
int (*ValueLinkerComponent_get_actorSoulLever)(void* instance);

bool (*Reqskill)(void *ins);
bool (*Reqskill2)(void *ins,bool bForce);
void* (*get_VHostLogic)();
void* (*get_playerCenter)();

EntityManager *espManager;
EntityManager *ActorLinker_enemy;



ImVec2 GetPlayerPosition(Vector3 Pos){
    Vector3 PosSC = Camera::get_main()->WorldToScreen(Pos);
    ImVec2 Pos_Vec2 = ImVec2(kWidth - PosSC.x*kWidth, PosSC.y*kHeight);
    if (PosSC.z > 0) {
        Pos_Vec2 = ImVec2(PosSC.x*kWidth, kHeight - PosSC.y*kHeight);
    }
    return Pos_Vec2;
}


float ClosestDistanceEnemy(Vector3 myPos, Vector3 enemyPos, Vector3 direction) 
{
    Vector3 AC = enemyPos - myPos; 
    Vector3 AB = direction; 
    float t = Vector3::Dot(AC, AB); 
    Vector3 projectionPoint = myPos + AB * t;
    return Vector3::Distance(projectionPoint, enemyPos);
}



void (*old_ActorLinker_ActorDestroy)(void *instance);
void ActorLinker_ActorDestroy(void *instance) {
    if (instance != NULL) {
        old_ActorLinker_ActorDestroy(instance);
		ActorLinker_enemy->removeEnemyGivenObject(instance);
        if (espManager->MyPlayer==instance){
            espManager->MyPlayer=NULL;
        }
    }
}

void (*old_LActorRoot_ActorDestroy)(void *instance,bool bTriggerEvent);
void LActorRoot_ActorDestroy(void *instance, bool bTriggerEvent) {
    if (instance != NULL) {
        old_LActorRoot_ActorDestroy(instance, bTriggerEvent);
        espManager->removeEnemyGivenObject(instance);
        
    }
}


int dem(int num){
    int div=1, num1 = num;
    while (num1 != 0) {
        num1=num1/10;
        div=div*10;
    }
    return div;
}

Vector3 VInt2Vector(VInt3 location, VInt3 forward){
    return Vector3((float)(location.X*dem(forward.X)+forward.X)/(1000*dem(forward.X)), (float)(location.Y*dem(forward.Y)+forward.Y)/(1000*dem(forward.Y)), (float)(location.Z*dem(forward.Z)+forward.Z)/(1000*dem(forward.Z)));
}

Vector3 VIntVector(VInt3 location)
{
    return Vector3((float)(location.X) / (1000), (float)(location.Y) / (1000), (float)(location.Z) / (1000));
}


bool AimSkill = false;
int aimType, drawType = 1, skillSlot;
bool IsCharging;

Vector3 calculateSkillDirection(Vector3 myPosi, Vector3 enemyPosi, Vector3 moveForward, int currentSpeed, float bullettime, float Ranger) 
{
    Vector3 futureEnemyPos = Vector3::zero();
    Vector3 toEnemy = enemyPosi - myPosi;
    float distanceToEnemy = Vector3::Magnitude(toEnemy);
    float defaultBulletSpeed = Ranger/bullettime;
    float timeToHit = distanceToEnemy/defaultBulletSpeed;
    futureEnemyPos = enemyPosi + moveForward * currentSpeed * timeToHit;
    Vector3 shootingDirection = futureEnemyPos - myPosi;
    return Vector3::Normalized(shootingDirection);
} 

std::map<uint64_t, Vector3> previousEnemyPositions;
Vector3 Lerp(Vector3 &a,const Vector3 &b, float t) 
{
    if(Vector3::Distance(a,b) > 1) a = b;
    return Vector3
    {
        a.x + (b.x - a.x) * t,
        a.y + (b.y - a.y) * t,
        a.z + (b.z - a.z) * t
    };
}

Vector3 RotateVectorByQuaternion(Quaternion q) 
{
    Vector3 v(0.0f, 0.0f, 1.0f);
    float w = q.w, x = q.x, y = q.y, z = q.z;
    Vector3 u(x, y, z);
    Vector3 cross1 = Vector3::Cross(u, v);
    Vector3 cross2 = Vector3::Cross(u, cross1);
    Vector3 result = v + 2.0f * cross1 * w + 2.0f * cross2;
    return result;
}


float SquaredDistance(Vector3 v, Vector3 o) 
{
    return (v.x - o.x) * (v.x - o.x) + (v.y - o.y) * (v.y - o.y) + (v.z - o.z) * (v.z - o.z);
}


int tagid1, tagid2, tagid3;



Vector3 (*_GetUseSkillDirection)(void *instance, bool isTouchUse);
Vector3 GetUseSkillDirection(void *instance, bool isTouchUse) 
{
    if (instance != NULL && AimSkill )
    // && std::find(targetConfigIDs.begin(), targetConfigIDs.end(), EnemyTarget.ConfigID) != targetConfigIDs.end()) 
    { 
        if (EnemyTarget.myPos != Vector3::zero() && 
        EnemyTarget.enemyPos != Vector3::zero() && (skillSlot == tagid1 || 
        skillSlot == tagid2 || skillSlot == tagid3)) 
        {   
            return calculateSkillDirection
            (
                EnemyTarget.myPos, 
                EnemyTarget.enemyPos, 
                EnemyTarget.moveForward, 
                EnemyTarget.currentSpeed,
                EnemyTarget.bullettime,
                EnemyTarget.Ranger
            );    
            }
        }
    return _GetUseSkillDirection(instance, isTouchUse);
}

/*
bool (*_UpdateLogic)(void *instance, int delta);
bool UpdateLogic(void *instance, int delta)
{
    if (instance != NULL)
    {
        isCharging = *(bool *)((uintptr_t)instance + m_isCharging);
        skillSlot = *(int *)((uintptr_t)instance + m_currentSkillSlotType);
    }
    return _UpdateLogic(instance, delta);
}
*/



static bool unlockskin     = false;    
static bool unlockskinsss  = false;
static int currentHeroId   = 0;
static int currentSkinId   = 0;         
static uint32_t heroId     = 0;        
static uint16_t skinId     = 0;        
static int Skill5View      = 0;        

// ================== UI ==================
void DrawHeroSkinInfo() 
{
    ImGui::Text("Hero: %u", currentHeroId);
    ImGui::SameLine(); ImGui::Text("Skin: %u", currentSkinId);
    ImGui::SameLine(); ImGui::Text("Skill: %d", Skill5View);
}


// ================== HERO CLASS ==================
class COMDT_HERO_COMMON_INFO {
public:
    uint32_t getHeroID() { 
        return *(uint32_t*)((uintptr_t)this  + dwHeroID_Field);// COMDT_HERO_COMMON_INFO
    }
    uint16_t getSkinID() { 
        return *(uint16_t*)((uintptr_t)this + wSkinID_Field); 
    }
    void setSkinID(uint16_t id){ 
        *(uint16_t*)((uintptr_t)this + wSkinID_Field) = id; /*unlockskinsss ? 1 :  id;*/
    }
};

// ================== HOOK ==================
typedef int32_t TdrErrorType;
class TdrReadBuf { 
public: 
    int32_t position,length; 
    bool isNetEndian,isUseCache; 
    std::vector<uint8_t> beginPtr; 
};

TdrErrorType (*old_unpack)(COMDT_HERO_COMMON_INFO*, TdrReadBuf&, int32_t);
TdrErrorType unpack(COMDT_HERO_COMMON_INFO* inst, TdrReadBuf& buf, int32_t ver) {
    auto r = old_unpack(inst, buf, ver);
    if (unlockskin /*|| unlockskinsss */ && inst->getHeroID() == heroId) {
        inst->setSkinID(skinId);
    }
    return r;
}


void (*old_RefreshHeroPanel)(void*, bool, bool, bool);
void (*old_OnClickSelectHeroSkin)(void*, uint32_t, uint32_t);
void OnClickSelectHeroSkin(void* ins, uint32_t hid, uint32_t sid) {
    if (unlockskin && hid) {
        heroId = hid;
        skinId = sid;
        old_RefreshHeroPanel(ins, 1, 1, 1);
    }
    old_OnClickSelectHeroSkin(ins, hid, sid);
}

bool (*old_IsCanUseSkin)(void*, uint32_t, uint32_t);
bool IsCanUseSkin(void* ins, uint32_t hid, uint32_t sid) {
   // if ((unlockskin || unlockskinsss)) { 
   if(unlockskin){
        heroId = hid; 
        skinId = sid; 
        return true; 
    }
    return old_IsCanUseSkin(ins, hid, sid);
}


bool (*old_IsHaveHeroSkin)(uint32_t, uint32_t, bool);
bool IsHaveHeroSkin(uint32_t hid, uint32_t sid, bool t = false) {
    return unlockskin ? true : old_IsHaveHeroSkin(hid, sid, t);
}

// ================== GET WEAR SKIN ==================
uint32_t (*old_GetHeroWearSkinId)(void* instance, uint32_t hero);
uint32_t GetHeroWearSkinId(void* instance, uint32_t hero) {
    currentHeroId = hero;
    uint32_t idSkin = 0;

    //if ((unlockskin || unlockskinsss)) {
    if(unlockskin){
        idSkin = (heroId == hero) ? skinId : skinId;
    } else {
        idSkin = old_GetHeroWearSkinId ? old_GetHeroWearSkinId(instance, hero) : 0;
    }

    currentSkinId = idSkin;

    UpdateTypeKill(currentHeroId, currentSkinId);

    return idSkin;
}

/*
struct SkinElement {};
SkinElement (*_GetSkin)(void* instance, int skinId);
SkinElement GetSkin(void* instance, int skinId) {
    if ((unlockskinsss) && instance && currentSkinId != 0) {
        return _GetSkin(instance, currentSkinId); 
    }
    return _GetSkin(instance, skinId);
}
*/

//=========================================
void *(*GetAwakeSkinData)(uint32_t wakeSkinID);
bool (*_IsAwakeSkin)(uint32_t wakeSkinID);
bool IsAwakeSkin(uint32_t wakeSkinID) {
	if (_IsAwakeSkin(wakeSkinID))
	{
		void *awakeSkin = GetAwakeSkinData(wakeSkinID);
		if (awakeSkin != nullptr)
		{
			*(uint8_t *)((uintptr_t)awakeSkin + Evo_Data_bCurWearLevel) = 5;//public byte bCurWearLevel; // 0x30
			*(uint8_t *)((uintptr_t)awakeSkin + Evo_Data_bWakeLevel) = 5;//public byte bWakeLevel; // 0x20
		    *(uint64_t *)((uintptr_t)awakeSkin + Evo_Data_ullWakeFeatureMask) = 2147483647;//public ulong ullWakeFeatureMask; // 0x28
			*(uint64_t *)((uintptr_t)awakeSkin + Evo_Data_ullWearFeatureMask) = 2147483647;//public ulong ullWearFeatureMask; // 0x38
		
		}
	}
	return _IsAwakeSkin(wakeSkinID);
}

TdrErrorType (*_unpack1)(uintptr_t instance, void **srcBuf, uint32_t cutVer);
TdrErrorType unpack1(uintptr_t instance, void **srcBuf, uint32_t cutVer){
	auto result = _unpack1(instance, srcBuf, cutVer);
	if (result) return result;
	
	*(uint8_t *)((uintptr_t)instance + unpack_bSkinWakeLevel) = 5;//public byte bSkinWakeLevel; // 0xC0
	*(uint64_t *)((uintptr_t)instance + unpack_ullSkinWakeFeatureMask) = 2147483647;//public ulong ullSkinWakeFeatureMask; // 0xC8
	
	
	return result;
}

bool ShowCD = false;
uintptr_t botro, cphutro, c1, c2, c3, Skill5OK;


void* myLactorRoot = nullptr;
void* myActorLinker = nullptr;
void* myActor = nullptr;
void* Lactor = nullptr;


int myId = 0;
int myObjID = 0;


typedef struct _monoString {
    void* klass;
    void* monitor;
    int length;    
    char chars[1];   // UTF-16LE data

    int getLength() {
        return length;
    }

    char* getChars() {
        return chars;
    }

    NSString* toNSString() {
        return [[NSString alloc] initWithBytes:(const void *)(chars)
                                        length:(NSUInteger)(length * 2)
                                      encoding:NSUTF16LittleEndianStringEncoding];
    }

    char* toCString() {
        NSString* v1 = toNSString();
        return (char*)([v1 UTF8String]);  
    }

    std::string toString() {
        return std::string(toCString());
    }

} monoString;


monoString *CreateMonoString(const char *str) {
    monoString *(*String_CreateString)(void *instance, const char *str, 
    int startIndex, int length) = (monoString *(*)(void *, 
    const char*, int, int))String_CreateStrings;//private string CreateString(sbyte* value, int startIndex, int length) { }
    return String_CreateString(NULL, str, 0, (int)strlen(str));
}

          
void* *(*get_actorManager)();
uintptr_t (*AsHero)(void*);

static std::unordered_map<uintptr_t, monoString*> g_NameOrg;
void (*SetPlayerName)(void*, monoString*, monoString*, bool, monoString*);
void _SetPlayerName(void* instance,   monoString* playerName,monoString* prefixName,bool isGuideLevel,monoString* customName)
{
    if (instance && playerName)
    {
        uintptr_t key = (uintptr_t)instance;
        if (g_NameOrg.find(key) == g_NameOrg.end())
        {
            g_NameOrg[key] = playerName;
        }
    }
   SetPlayerName(instance,playerName,prefixName, isGuideLevel, customName);
}

void (*old_Update)(void*);
void AUpdate(void* instance)
{
    if (!instance)
    {
        old_Update(instance);
        return;
    }

    uintptr_t skillControl = (uintptr_t)AsHero(instance);
    uintptr_t HudControl   = *(uintptr_t*)((uintptr_t)instance + Esp_ActorLinker_HudControl);

   // bool (*IsHostPlayer)(void*) = (bool (*)(void*))getRealOffset(0x64043D8);//ActorLinker / public bool IsHostPlayer() { }
   // int (*get_playerId)(void*) = (int (*)(void*))getRealOffset(0x63FABC8);//ActorLinker / public uint get_playerId() { }
   
   
    if (ActorLinker_IsHostPlayer(instance))
    {
         myActor = instance;
    }

    if (HudControl > 0 && skillControl > 0)
    {
        int cd1  = (int)ceil(*(int*)((uint64_t)skillControl + c1    - 0x4) / 1000.0);
        int cd2  = (int)ceil(*(int*)((uint64_t)skillControl + c2    - 0x4) / 1000.0);
        int cd3  = (int)ceil(*(int*)((uint64_t)skillControl + c3    - 0x4) / 1000.0);
        int cdBT = (int)ceil(*(int*)((uint64_t)skillControl + botro - 0x4) / 1000.0);

        std::string sk1 = (cd1  == 0) ? " [ A ] "   : " [ " + std::to_string(cd1)  + " ] ";
        std::string sk2 = (cd2  == 0) ? " [ O ] "   : " [ " + std::to_string(cd2)  + " ] ";
        std::string sk3 = (cd3  == 0) ? " [ V ] "   : " [ " + std::to_string(cd3)  + " ] ";
        std::string sk4 = (cdBT == 0) ? " [ NmkiOSVN ] " : " [ " + std::to_string(cdBT) + " ] ";

        if (ShowCD)
        {
            monoString* playerName = CreateMonoString((sk1 + sk2 + sk3).c_str());
            monoString* prefixName = CreateMonoString(sk4.c_str());
            _SetPlayerName((void*)HudControl,playerName,prefixName,true,NULL
            );
        }
        else
        {
            auto it = g_NameOrg.find(HudControl);
            if (it != g_NameOrg.end())
            {
                _SetPlayerName((void*)HudControl,it->second,CreateMonoString(""),false,NULL);
            }
        }
    }
    // Gọi lại hàm update gốc
    old_Update(instance);
    if (ActorLinker_ActorTypeDef(instance)== 0){
        if (ActorLinker_IsHostPlayer(instance)== true){
            espManager->tryAddMyPlayer(instance);
             myObjID = ActorLinker_get_ObjID(instance);
              Lactor = instance;
              myActorLinker = instance;
            } else {
				if(espManager->MyPlayer != NULL) {
					if(ActorLinker_COM_PLAYERCAMP(espManager->MyPlayer) != ActorLinker_COM_PLAYERCAMP(instance)){
						ActorLinker_enemy->tryAddEnemy(instance);
					}
				}
           }
     }

}



int AutoWinTowerMode = 0; // 1: Tắt, 2: Trụ địch, 3: Trụ mình
bool AutoWinz = false;

bool IsNativeObjectAlive(void *unity_obj) {
    return (unity_obj != nullptr && (*(uintptr_t *)((uintptr_t)unity_obj + 0x8))); // class Object -> private IntPtr m_CachedPtr; // 0x10
}

void (*old_LActorRoot_UpdateLogic)(void *instance, int delta);
void LActorRoot_UpdateLogic(void *instance, int delta) {
    if (instance != NULL) {

        old_LActorRoot_UpdateLogic(instance, delta);

    static const auto AsOrgan = (void * (*)(void *))Esp_LActorRoot_AsOrgan;//LActorRoot / public LOrganWrapper AsOrgan() { }
    static const auto IsOwner = (bool (*)(void *))Esp_LActorRoot_IsOwner;//LActorRoot / public Boolean IsOwner(LActorRoot actor) { }
    static const auto get_isTower = (bool (*)(void *)) Esp_LOrganWrapper_get_isTower;//LOrganWrapper / public Boolean get_isTower() { }
    static const auto get_actorHp = (int (*)(void *)) Esp_ValuePropertyComponent_get_actorHp;//ValuePropertyComponent / public Int32 get_actorHp() { }
    static const auto set_actorHp = (int (*)(void *, int)) Esp_ValuePropertyComponent_set_actorHp;//ValuePropertyComponent / public Void set_actorHp(Int32 value) { }
    static const auto get_objCamp = (int (*)(void *)) Esp_ActorLinker_get_objCamp;//ActorLinker / public COM_PLAYERCAMP get_objCamp() { }
    static const auto GiveMyEnemyCamp = (int (*)(void *)) Esp_LActorRoot_GiveMyEnemyCamp;//LActorRoot / public COM_PLAYERCAMP GiveMyEnemyCamp() { }

    if (instance && IsNativeObjectAlive(myActor)) {
        if (GiveMyEnemyCamp(instance) != get_objCamp(myActor)) {
            myLactorRoot = instance;
        }
        if (AutoWinz){
            void *organ = AsOrgan(instance);
            if (organ && !get_isTower(organ)){
                void *valueComponent = *(void **)((uintptr_t)instance + Esp_LActorRoot_ValueComponent);//	LActorRoot / public ValuePropertyComponent ValueComponent; // 0x310
                if (valueComponent && get_actorHp(valueComponent) > 0) {
                    bool bEnemy = GiveMyEnemyCamp(instance) == get_objCamp(myActor);
                    if (AutoWinTowerMode == 0 && bEnemy) set_actorHp(valueComponent, 0);
                    if (AutoWinTowerMode == 1 && !bEnemy) set_actorHp(valueComponent, 0);
                }
            }
        }
    }
    if (espManager->MyPlayer!=NULL) {
            if (LActorRoot_LHeroWrapper(instance)!=NULL && LActorRoot_COM_PLAYERCAMP(instance) == ActorLinker_COM_PLAYERCAMP(espManager->MyPlayer)) {
				espManager->tryAddEnemy(instance);
			}
        }
    }
}


Vector3 CurrentPosition;
Vector3 myPos;
bool autott;
bool rongta;
bool onlymt = false;

float Rangeskill0;
float Rangeskill1;
float Rangeskill2;
float Rangeskill3;
float Rangeskill5;

void* Req0 = nullptr;
void* Req1 = nullptr;
void* Req2 = nullptr;
void* Req3 = nullptr;
void* Req4 = nullptr;
void* Req5 = nullptr;
void* Req6 = nullptr;
void* Req9 = nullptr;
void* Req13 = nullptr;

bool autobocpha = false;
bool hoimau = false;
bool capcuuz = false;
bool bangsuongz = false;

int slot;
int range;


static int Hud;
static int Hudh;
static int Level;

float mauphutro = 13.79f;  // % máu
float maubotro = 12.67f;    // % máu
float maucapcuu = 18.45f;  // % máu
float mauhoimau = 16.2f; // % máu


void (*_Skslot)(void *ins, int del);
void Skslot(void *ins, int del) {
  if (ins != NULL) {

    slot = *(int *)((uintptr_t)ins + Skil_SkillSlot_SlotType);// public SkillSlotType SlotType; // 0x80
    void* skillControls = *(void**) ((uintptr_t)ins + Skil_SkillSlot_skillIndicator);//public SkillControlIndicator skillIndicator; // 0xB8
    range = *(int*) ((uintptr_t)skillControls + Skil_SkillControlIndicator_curindicatorDistance);//private int curindicatorDistance; // 0x170
    Vector3 currentPosition = *(Vector3*) ((uintptr_t)skillControls + SkillControlIndicator_useSkillDirection);//public Vector3 useSkillDirection; // 0x38

     if(slot == 1)//Chiêu 1
    { 
     Req1 = ins;
     Rangeskill1 = (float)range/1000.0f;
    }
    if(slot == 2) //Chiêu 2
    { 
     Req2 = ins;
     Rangeskill2 = (float)range/1000.0f;
    }
    if(slot == 3) //Chiêu 3
    { 
     Req3 = ins;
     Rangeskill3 = (float)range/1000.0f;
    }
    if(slot == 4) //Hồi máu
    { Req4 = ins; }

    if(slot == 5) //bổ trợ
    { Req5 = ins; }

    if(slot == 6) //Biến Về
    { Req6 = ins; }

    if(slot == 9) //Phù Trợ
    { Req9 = ins; }

    if(slot == 13)
    { Req13 = ins; }

    if(slot == 0) //Đánh Thường
    { Req0 = ins;
      Rangeskill0 = (float)range/1000.0f;
    }
    
    if(slot == skillSlot)
    { CurrentPosition = currentPosition; }


    if (myActor != NULL) 
    {
        // Kiểu loại điều khiển
        auto SkillControl = AsHero(myActor); 
        Skill5View = *(int*)(SkillControl + Skill5OK);
    }

    if (myActor != NULL) 
    {
     // Kiểu loại điều khiển
     auto SkillControls = AsHero(myActor); 
     // Lấy ID của bổ trợ
     int Skill5 = *(int*)(SkillControls + Skill5OK);
     int Skill4 = *(int*)(SkillControls + c3);

        void *Valuec2 = *(void **)((uint64_t)myActor + Esp_ActorLinker_ValueComponent);
        int Hp  = ValueLinkerComponent_get_actorHp(Valuec2);
        int Hpt = ValueLinkerComponent_get_actorHpTotal(Valuec2);
        float Per = ((float)Hp / (float)Hpt) * 100.0f;
        if (bangsuongz && Per <= mauphutro && slot == 9 && mauphutro > 1.0f) {
          Reqskill(ins);
        }
          if (capcuuz && Per <= maucapcuu && slot == 5 && maucapcuu > 1.0f) {
          if (Skill5 == 80102){ // ID Cấp cứu
          Reqskill(ins); 
          }
        } 
          if (hoimau && Per <= mauhoimau && slot == 4 && mauhoimau > 1.0f) {
          if (Skill4 == 90000 || Skill4 == 91000 || Skill4 == 90003){
          Reqskill(ins);
         }
        }
     }

/*
     void* actorManager = get_actorManager();
        if (actorManager == nullptr) return;
      List<void**> *GetAllMonsters = *(List<void**>**)((uint64_t)actorManager + 0x48);//class ActorManager / MonsterActors; // 0x48
        if (GetAllMonsters == nullptr) return;
        void* **actorLinkersm = (void* **) GetAllMonsters->getItems();
        if (actorLinkersm == NULL) return;

     if (autott)  {

        for (int i = 0; i < GetAllMonsters->getSize(); i++) {
            void* actorLinker = actorLinkersm[(i *2) + 1];
            if (actorLinker == NULL) continue;
        
        void *ValueComponent = *(void **)((uintptr_t)actorLinker + 0x28);
        int Healtho = ValueLinkerComponent_get_actorHp(ValueComponent);
       if (Healtho < 1) continue;

        //void *HudControl = *(void **)((uintptr_t)actorLinker + 0x70);////public HudComponent3D HudControl; // 0x70
         //Hud = *(int *)((uintptr_t)HudControl + 0x34);//public HudCompType HudType; // 0x34
        // Hudh = *(int *)((uintptr_t)HudControl + 0x30);//public int hudHeight; // 0x30
        Vector3 myPoas = Vector3::zero();
         Vector3 EnemyPos = ActorLinker_getPosition(actorLinker);
         void *ValueComponento = *(void **)((uintptr_t)actorLinker + 0x28);//public ValueLinkerComponent ValueComponent; // 0x28
         int Health = ValueLinkerComponent_get_actorHp(ValueComponento);
          int MaxHealth = ValueLinkerComponent_get_actorHpTotal(ValueComponento);
          int Level = ValueLinkerComponent_get_actorSoulLever(ValueComponento);
          float Distance = Vector3::Distance(myPoas, EnemyPos);

         // auto SkillControl = AsHero(Lactor);
          //int Skill5 = *(int*)(SkillControl + Skill5OK);
          
          void *ObjLinker = *(void **)((uintptr_t)actorLinker + 0x118);//public ActorConfig ObjLinker; // 0x118
          int ConfigIDMT = *(int*)((uintptr_t)ObjLinker + 0x1C);//public int ConfigID; // 0x1C
          if(ConfigIDMT == 7010 || ConfigIDMT == 7011 || ConfigIDMT == 7012 || ConfigIDMT == 70093 || ConfigIDMT == 70092 || ConfigIDMT == 7024 || ConfigIDMT == 7009){
        
          if ((Distance < 5.0f && Health <= (1350 + (100 * (Level - 1))) && 
                Hud == 1 && onlymt && (Hudh == 2900 ||  Hudh == 3250))
                ||(Distance < 5.0f && Health <= (1350 + (100 * (Level - 1))) && 
                rongta && Hud == 4 ))    
            {
            
            if(Distance < 5.0f){

              //if (Skill5 == 80104 || Skill5 == 80116)
               // {
                Reqskill2(Req5, false); 
                Reqskill(Req5);
              //  }
           }
        }
      }
    }
*/

/*
       float minDistance = std::numeric_limits<float>::infinity();
    float minDirection = std::numeric_limits<float>::infinity();
    float minHealth = std::numeric_limits<float>::infinity();
    float minHealth2 = std::numeric_limits<float>::infinity();

    // Lấy quản lý actor
    ActorManager *get_actorManager = KyriosFramework::get_actorManager();
    if (get_actorManager == nullptr) return;

    List<ActorLinker *> *GetAllMonsters = get_actorManager->GetAllMonsters();
    if (GetAllMonsters == nullptr) return;

    ActorLinker **actorLinkersm = (ActorLinker **) GetAllMonsters->getItems();

    if (autott) 
    {
        //rongta = true;

        for (int i = 0; i < GetAllMonsters->getSize(); i++){
            ActorLinker *actorLinker = actorLinkersm[(i * 2) + 1];
            if (actorLinker == nullptr) continue;
    
            if (actorLinker->ValueComponent()->get_actorHp() < 1) continue;
            
            EnemyTarget.Hud = actorLinker->HudControl()->Hud();
            EnemyTarget.Hudh = actorLinker->HudControl()->Hudh();  
            
            Vector3 EnemyPos = actorLinker->get_position();
            float Health = actorLinker->ValueComponent()->get_actorHp();
            float MaxHealth = actorLinker->ValueComponent()->get_actorHpTotal();
            float Distance = Vector3::Distance(EnemyTarget.myPos, EnemyPos);
                     
            auto SkillControl = AsHero(Lactor);
            int Skill5 = *(int*)(SkillControl + Skill5OK);
            int ConfigIDMT = actorLinker->ObjLinker()->ConfigID(); // id quái rừng
            if(ConfigIDMT == 7010 || ConfigIDMT == 7011 || ConfigIDMT == 7012 || ConfigIDMT == 70093 || ConfigIDMT == 70092 || ConfigIDMT == 7024 || ConfigIDMT == 7009)
            {       
            if ( // Điều kiện 1: Trừng trị Bùa xanh, Bùa đỏ
                (Distance < 5.0f && Health <= (1350 + (100 * (EnemyTarget.Level - 1))) && 
                EnemyTarget.Hud == 1 && onlymt && (EnemyTarget.Hudh == 2900 ||  EnemyTarget.Hudh == 3250))
                || // Điều kiện 2: Trừng trị Tà Thần và Rồng
              
                (Distance < 5.0f && Health <= (1350 + (100 * (EnemyTarget.Level - 1))) && 
                rongta && EnemyTarget.Hud == 4 )  
            )    
            {        
                if (Skill5 == 80104 || Skill5 == 80116)
                {
                Reqskill2(Req5, false); 
                Reqskill(Req5);
                }
            }
        }
      }
    }

    List<ActorLinker *> *GetAllHeros = get_actorManager->GetAllHeros();
    if (GetAllHeros == nullptr) return;
    ActorLinker **actorLinkers = (ActorLinker **) GetAllHeros->getItems();    
    for (int i = 0; i < GetAllHeros->getSize(); i++) 
    {
        ActorLinker *actorLinker = actorLinkers[(i * 2) + 1];
        if (actorLinker->IsHostPlayer()) 
        { // xong
          EnemyTarget.myPos = actorLinker->get_position();
          EnemyTarget.ConfigID = actorLinker->ObjLinker()->ConfigID();
         EnemyTarget.Level = actorLinker->ValueComponent()->Level();
        } // xong
} 



*/


    if (Lactor != NULL) 
    {
     // Kiểu loại điều khiển
      auto SkillControl = AsHero(Lactor); 
      // Lấy ID của bổ trợ
      int Skill5x = *(int *)(SkillControl + Skill5OK);    

         for (int i = 0; i < espManager->enemies->size(); i++) {
         void *actorLinker = espManager->MyPlayer;
         if (actorLinker != nullptr) {
        void *Enemy = (*espManager->enemies)[i]->object;
         if (Enemy != nullptr) {
        void *EnemyLinker = (*ActorLinker_enemy->enemies)[i]->object;
        if (EnemyLinker != nullptr) {
             Vector3 EnemyPos = Vector3::zero();

         VInt3 NowLocation = LActorRoot_get_location(Enemy);
         VInt3 forwardEnemy = LActorRoot_get_forward(Enemy);
        
         Vector3 myPos = ActorLinker_getPosition(actorLinker);
         EnemyPos = VInt2Vector(NowLocation,forwardEnemy);

         void *ValuePropertyComponent = *(void **)((uint64_t)Enemy + Esp_LActorRoot_ValueComponent);//public ValuePropertyComponent ValueComponent; // 0x308
         float distanceToMe = Vector3::Distance(myPos, EnemyPos);
         int EnemyHp = ValuePropertyComponent_get_actorHp(ValuePropertyComponent);
         int EnemyHpTotal = ValuePropertyComponent_get_actorHpTotal(ValuePropertyComponent);
         float PercentHP = ((float)EnemyHp / (float)EnemyHpTotal) * 100.0f;

              if (autobocpha && PercentHP < maubotro && distanceToMe < 5.0 && slot == 5 && PercentHP > 1.0f) {
              if (Skill5x == 80108) { Reqskill(ins); }
            }
          }
           }
         }
        }
      }
  }
return _Skslot(ins, del);
}


void (*_SkillButtonManager_LateUpdate)(void *instance);
void SkillButtonManager_LateUpdate(void *instance)
{
    if (instance != NULL)
    {
        skillSlot = GetCurSkillSlotType(instance);
        IsCharging = get_IsCharging(instance);
        
        /*
        if (myActor)
        {
                void *ValueLinkerComponent = *(void **)((uint64_t)myActor + 0x28);
                float myHealthP = (float)ValueLinkerComponent_get_actorHp(ValueLinkerComponent) / ValueLinkerComponent_get_actorHpTotal(ValueLinkerComponent);
                if (myHealthP <= mauphutro / 100.0f)
                {
                    RequestUseSkillSlot(instance, 9, 0, 0, 0);
                }
        }
        */


    }
    return _SkillButtonManager_LateUpdate(instance);
}


struct BugSkillInfo {
    int skillID;
    float rangeOrigin;
    float rangeFuture;

    BugSkillInfo()
        : skillID(0), rangeOrigin(0.0f), rangeFuture(0.0f) {}

    BugSkillInfo(int id, float origin, float future)
        : skillID(id), rangeOrigin(origin), rangeFuture(future) {}
};

BugSkillInfo GetEnemySkillRangeByID(int Hero_ConfigID)
{
    BugSkillInfo info;

    switch (Hero_ConfigID)
    {
        case Thane:       info = BugSkillInfo(2, 3.4f, 7.4f); break;
        case Keera:       info = BugSkillInfo(1, 4.9f, 7.0f); break;
        case Zuka:        info = BugSkillInfo(3, 5.4f, 7.4f); break;
        case Maloch:      info = BugSkillInfo(3, 11.9f, 13.0f); break;
        case Tachi:       info = BugSkillInfo(3, 7.9f, 8.5f); break;
        case Paine:       info = BugSkillInfo(3, 19.9f, 21.7f); break;
        case Nakroth:     info = BugSkillInfo(1, 5.4f, 6.8f); break;
        case Zill:        info = BugSkillInfo(2, 6.9f, 7.5f); break;
        case Slimz:       info = BugSkillInfo(2, 5.9f, 6.3f); break;
        case Aoi:         info = BugSkillInfo(1, 5.4f, 7.1f); break;
        case Xeniel:      info = BugSkillInfo(2, 5.9f, 6.4f); break;
        case Kriknak:     info = BugSkillInfo(3, 6.9f, 7.5f); break;
        case Zephys:      info = BugSkillInfo(3, 6.4f, 7.0f); break;
        case Taara:       info = BugSkillInfo(1, 6.4f, 8.0f); break;
        case Lorion:      info = BugSkillInfo(1, 8.9f, 11.5f); break;
        case Azzenka:     info = BugSkillInfo(1, 8.9f, 10.9f); break;
        case Krixi:       info = BugSkillInfo(2, 6.9f, 8.4f); break;
        case Kahlii:      info = BugSkillInfo(1, 7.9f, 8.5f); break;
        case Alice:       info = BugSkillInfo(1, 8.9f, 9.8f); break;
        case Mganga:      info = BugSkillInfo(1, 7.4f, 9.5f); break;
        case Dirak:       info = BugSkillInfo(2, 10.4f, 11.5f); break;
        case Fennik:      info = BugSkillInfo(3, 8.9f, 9.7f); break;
        case DieuThuyen:  info = BugSkillInfo(7, 7.9f, 8.6f); break;
        case Annette:     info = BugSkillInfo(1, 8.9f, 11.0f); break;
        case Celica:      info = BugSkillInfo(2, 8.9f, 9.7f); break;
        case Preyta:      info = BugSkillInfo(2, 7.9f, 8.7f); break;
        case Moren:       info = BugSkillInfo(3, 7.4f, 8.2f); break;
        case Ishar:       info = BugSkillInfo(3, 7.9f, 8.6f); break;
        case Liliana:     info = BugSkillInfo(4, 7.9f, 8.9f); break;
        case Sinestrea:   info = BugSkillInfo(2, 8.4f, 9.2f); break;
        case DArcy:       info = BugSkillInfo(6, 8.4f, 9.2f); break;
        case Ignis:       info = BugSkillInfo(6, 8.4f, 9.2f); break;
        default:          info = BugSkillInfo(); break;
    }

    return info;
}

static bool bugskillon = true;
static bool activebug  = false;

enum NameHeroID { Toro = 105, Krixi = 106, Zephys = 107, Gildur = 108, 
Veera = 109, Kahlii = 110, Violet = 111, Yorn = 112, Chaugnar = 113, 
Omega = 114, Jinna = 115, Butterfly = 116, Ormarr = 117, Alice = 118,
Mganga = 119, Mina = 120, Marja = 121, Maloch = 123, Ignis = 124,
Arduin = 126, Azzenka = 127, LuBo = 128, TrieuVan = 129, Airi = 130,
Murad = 131, Hayate = 132, Valhein = 133, Skud = 134, Thane = 135,
Ilumia = 136, Paine = 137, KilGroth = 139, SuperMan = 140, Lauriel = 141, 
Natalya = 142, Taara = 144, Zill = 146, Preyta = 148, Xeniel = 149, 
Nakroth = 150, DieuThuyen = 152, Kaine = 153, Yena = 154, Aleister = 156,
Raz = 157, Dolia = 159, Kriknak = 162, Ryoma = 163, Athur = 166, Ngokhong = 167,
Lumburr = 168, Slimz = 169, Moren = 170, Cresh = 171, Fennik = 173, Stuart = 174,
Grakk = 175, Lindis = 177, Max = 180, Helen = 184, Teemee = 186, Arum = 187, 
Krizzix = 189, Tulen = 190, Rouie = 191, Celica = 192, Amily = 193, Wiro = 194,
Enzo = 195, Elsu = 196, Elandorr = 199, Charlotte = 206, Telannas = 501, Astrid = 502,
Zuka = 503, WonderWoman = 504, Baldum = 505, Omen = 506, TheFlash = 507, Wisp = 508, 
Ybneth = 509, Liliana = 510, Ata = 511, Rourke = 512, Zata = 513, Roxie = 514, Richter = 515,
Quillen = 518, Annette = 519, Veres = 520, Florentino = 521, Errol = 522, DArcy = 523,
Capheny = 524, Zip = 525, Ishar = 526, Sephera = 527, Qi = 528, Volkath = 529, Dirak = 530,
Keera = 531, Thorne = 532, Laville = 533, Dextra = 534, Sinestrea = 535, Aoi = 536,
Allain = 537, Iggy = 538, Lorion = 539, Bright = 540, Bonnie = 541, Tachi = 542, Aya = 543,
Yan = 544, Yue = 545, Terri = 546, Bijan = 548, Erin = 567, Ming = 568, Biron = 597, BoltBaron = 598,
RoiAthur = 808, RoiTelannas = 809, Billow = 599, Capcuu = 80102, Ngatngu = 80103, Trungtri1 = 80104,
Suynhuoc = 80105, Thanhtay = 80107, Bocpha = 80108, Tochanh = 80109, Gamthet = 80110, Camtru = 80114,
Tocbien = 80115, Trungtri = 80116, Heino = 563, Goverra = 596, Vebinh = 80133 };


void (*LateUpdateBug)(void* instance,int ndelta);
void _LateUpdateBug(void* instance,int ndelta)
{
    LateUpdateBug(instance,ndelta);
    if(bugskillon)
    {
        int Hero_ConfigID = ActorLinker_ConfigId(myActor);
       
        void* SkillSlot = *(void**)((uintptr_t)instance + 0x18);//public SkillSlot skillSlot; // 0x18
        if(SkillSlot != NULL)
        {
            int usingslot = 0;
            int SkillSlotType = *(int*)((uintptr_t)SkillSlot + 0x80);//public SkillSlotType SlotType; // 0x80
            BugSkillInfo enemyInfo = GetEnemySkillRangeByID(Hero_ConfigID);
            if(enemyInfo.skillID > 0)
            {
                usingslot = enemyInfo.skillID;
                if(enemyInfo.skillID == 6 && Hero_ConfigID == DArcy)
                {
                    if(SkillSlotType == 2)
                    {
                        enemyInfo.rangeOrigin = 8.9f;
                        enemyInfo.rangeFuture = 10.9f;
                        usingslot = 2;
                    }
                    else if(SkillSlotType == 3)
                    {
                        enemyInfo.rangeOrigin = 7.9f;
                        enemyInfo.rangeFuture = 8.7f;
                        usingslot = 3;
                    }
                }
                else if(enemyInfo.skillID == 7)
                {
                    if(SkillSlotType == 1)
                    {
                        usingslot = 1;
                    }
                    else if(SkillSlotType == 2)
                    {
                        usingslot = 2;
                    }
                    else if(SkillSlotType == 3)
                    {
                        usingslot = 3;
                    }
                }
                else if(enemyInfo.skillID == 4)
                {
                    if(SkillSlotType == 1)
                    {
                        usingslot = 1;
                    }
                    else if(SkillSlotType == 2)
                    {
                        usingslot = 2;
                    }
                }
                if(usingslot == SkillSlotType)
                {
                    int iGuideDistance =std::max((int)((enemyInfo.rangeFuture)* 1000.0f),0);
                    void* ResSkillCfgInfo = *(void**)((uintptr_t)instance + 0x118);//private ResSkillCfgInfo curSkillCfg; // 0x118

                    if (ResSkillCfgInfo)
                    {
                        if(activebug)
                        {
                            *(int*)((uintptr_t)ResSkillCfgInfo + 0x108) = iGuideDistance;
                            *(int*)((uintptr_t)ResSkillCfgInfo + 0x104) = iGuideDistance;
                        }
                        else
                        {
                            *(int*)((uintptr_t)ResSkillCfgInfo + 0x108) = (int)enemyInfo.rangeOrigin*1000;
                            *(int*)((uintptr_t)ResSkillCfgInfo + 0x104) = (int)enemyInfo.rangeOrigin*1000;
                        }
                    }
                }
            }
        }
    }
}





NSArray *loadJSON(NSString *urlString) {
    NSURL *url = [NSURL URLWithString:urlString];
    NSData *data = [NSData dataWithContentsOfURL:url];
    if (!data) return nil;
    NSError *error;
    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    if (error) return nil;
    return jsonArray;
}

void loadOptionsOnline() {

    NSArray *options1 =
loadJSON(NSSENCRYPT("https://gist.githubusercontent.com/Bnam44/df57c066b65c961ff7dcad1c36925471/raw/OptionsButton.json"));
    if (options1) {
    OptionsButton.clear();
    for (NSDictionary *dict in options1) {
        const char *name = strdup([[dict[@"name"] description] UTF8String]);
        int idVal = [dict[@"id"] intValue];
        OptionsButton.push_back({name, idVal});
       }
    }


    NSArray *arr =
loadJSON(NSSENCRYPT("https://gist.githubusercontent.com/Bnam44/9de7220c24986ea28a78c720d8c5ac61/raw/OptionsNotification.json"));
    if (!arr) return;
    options2.clear();
    for (NSDictionary *dict in arr) {
        Option opt;
        opt.name = [dict[@"name"] UTF8String];
        opt.value = [dict[@"value"] intValue];
        opt.typeKill = [dict[@"typeKill"] intValue];
        options2.push_back(opt);
    }
}


static bool modbutton = true;
static int selectedbutton = 0;
// Mảng lưu danh sách từ JSON
static std::vector<std::pair<std::string, int>> OptionsButton;

bool (*old_IsOpen)(void* instance);
bool IsOpen(void* instance)
{
 if(modbutton){
  return true;
 }
 return old_IsOpen(instance);
}


void DrawModButton()
{
    if (OptionsButton.empty()) return;
    std::vector<const char*> items;
    for (auto &opt : OptionsButton) {
        items.push_back(opt.first.c_str());
    }
    ImGui::Combo("Hiệu Ứng Nút", &selectedbutton, items.data(), (int)items.size());
}

int (*old_get_PersonalBtnId)(void *instance);
int get_PersonalBtnId(void *instance) {
    if (modbutton && selectedbutton >= 0 && selectedbutton < (int)OptionsButton.size()) {
        if (selectedbutton == 1) {
            // Dùng giá trị đã có, không gọi lại GetHeroWearSkinId
            return currentHeroId * 100 + currentSkinId;
        } else {
            return OptionsButton[selectedbutton].second;
        }
    }
    return old_get_PersonalBtnId(instance);
}


bool modnotify = true;
int selectedValue2 = 0;
int TypeKill = 0;

struct Option {
    std::string name;
    int value;
    int typeKill;
};

static std::vector<Option> options2;

static void UpdateTypeKill(int heroId, int skinId) {
    currentHeroId = heroId;
    currentSkinId = skinId;
    if (selectedValue2 == 1) {
        int heroSkinId = currentHeroId * 100 + currentSkinId;
        for (size_t i = 2; i < options2.size(); i++) {
            if (options2[i].value == heroSkinId) {
                TypeKill = options2[i].typeKill;
                return;
            }
        }
        TypeKill = 0;
    } else {
        TypeKill = options2[selectedValue2].typeKill;
    }
}

void DrawModNotify() {
    if (options2.empty()) return;
    std::vector<const char*> items;
    for (auto &opt : options2) items.push_back(opt.name.c_str());
    if(ImGui::Combo("Thông Báo Hạ", &selectedValue2, items.data(), (int)items.size())){
    UpdateTypeKill(currentHeroId, currentSkinId); // update ngay khi đổi option
    }
}





static int SkinLinh = 0;
static int TopSelected = 0;
static bool enableTopSelect = false;
static bool TopSelect_active = false;
static int CucTop = 0;
static int SetUi = 0;
static int SetUi2 = 0;
long long MyUUID = 0;

/*
void ModTopLQ()
{
   const char* TopDz[] = { "Top Sơ Cấp", "Top Trung Cấp", "Top Cao Cấp", "Top Huyền Thoại", "Top Máy Chủ", "Top 1 Máy Chủ" };
//if (enableTopSelect)
//{
    ImGui::Combo("##CucTop", &TopSelected, TopDz, IM_ARRAYSIZE(TopDz));
     //}
    switch (TopSelected) {
        case 0: 
            SetUi = 2030;
            SetUi2 = 32;
            CucTop = 100; 
            break;
        case 1: 
            SetUi = 2030;
            SetUi2 = 32;
            CucTop = 4; 
            break;
        case 2: 
            SetUi = 2030;
            SetUi2 = 32;
            CucTop = 3; 
            break;
        case 3: 
            SetUi = 2030;
            SetUi2 = 32;
            CucTop = 2; 
            break;
        case 4: 
            SetUi = 2030;
            SetUi2 = 32;
            CucTop = 5; 
            break;
        case 5: 
            SetUi = 2030;
            SetUi2 = 32;
            CucTop = 1; 
            break;
    }
    ImGui::SameLine();
    CustomCheckbox("Mod Top", &enableTopSelect);
SaveSettings();
}
*/

void* (*_BattleStatic)(void* instance, int inPlayerID);
void* BattleStatic(void* instance, int inPlayerID) {
    if (instance != NULL) {
        MyUUID = *(long long *)((uintptr_t)instance + 0x10);////public ulong ulAccountUid; // 0x10
         //MyPlayerID = *(uint32_t *)((uintptr_t)instance + 0xC);//public uint uPlayerID; // 0xC
    }
    return _BattleStatic(instance, inPlayerID);
}

void* (*_GetPlayer)(void* instance, int delta);
void* GetPlayer(void* instance, int delta) {
    void* PlayerBase = _GetPlayer(instance, delta);
    if (PlayerBase != NULL) 
    {
        long long All_PlayerUId = *(long long *)((uint64_t)PlayerBase + 0x18);//public ulong PlayerUId; // 0x18
        if (All_PlayerUId == MyUUID)
        {
            *(int *)((uint64_t)PlayerBase + 0xFC) = TypeKill;

            if(SkinLinh == 0) *(int *)((uint64_t)PlayerBase + 0x128) = 93000;
            if(SkinLinh == 1) *(int *)((uint64_t)PlayerBase + 0x128) = 93001;
            if(SkinLinh == 2) *(int *)((uint64_t)PlayerBase + 0x128) = 93002;
            if(SkinLinh == 3) *(int *)((uint64_t)PlayerBase + 0x128) = 93003;

            if (enableTopSelect)
            {
                *(uint64_t*)((uintptr_t)PlayerBase + 0x108) = SetUi;//public uint showTitleID; // 0x108
                *(int*)((uintptr_t)PlayerBase + 0x110) = SetUi2;//public ulong showTitleMask; // 0x110
                *(int*)((uintptr_t)PlayerBase + 0x124) = CucTop;//public int legendTitleFlag; // 0x124
            }
             else
            {
                 *(uint64_t*)((uintptr_t)PlayerBase + 0x108);
                 *(int*)((uintptr_t)PlayerBase + 0x110);
                 *(int*)((uintptr_t)PlayerBase + 0x124);
             }
        }
    }
    return PlayerBase;
}

// Struct rank setting
struct RankSetting {
    const char* name;
    int LitStar;
    int maxStar;
    int IDRank;
    int ThackDau;
};

RankSetting ranks[] = {
    { "Đồng III", 0, 3, 1, 100},
    { "Đồng II", 0, 3, 2, 100},
    { "Đồng I", 0, 3, 3, 100},
    { "Bạc III", 0, 4, 4, 100},
    { "Bạc II", 0, 2, 5, 100},
    { "Bạc I", 0, 3, 6, 100},
    { "Vàng IV", 0, 4, 17, 100},
    { "Vàng III", 0, 4, 7, 100},
    { "Vàng II", 0, 4, 8, 100},
    { "Vàng I", 0, 4, 9, 100},
    { "Bạch Kim V", 0, 5, 18, 100},
    { "Bạch Kim IV", 0, 5, 19, 100},
    { "Bạch Kim III", 0, 5, 10, 100},
    { "Bạch Kim II", 0, 5, 11, 100},
    { "Bạch Kim I", 0, 5, 12, 100},
    { "Kim Cương V", 0, 5, 20, 100},
    { "Kim Cương IV", 0, 5, 21, 100},
    { "Kim Cương III", 0, 5, 13, 100},
    { "Kim Cương II", 0, 5, 14, 100},
    { "Kim Cương I", 0, 5, 15, 100},
    { "Tinh Anh V", 0, 5, 22, 100},
    { "Tinh Anh IV", 0, 5, 23, 100},
    { "Tinh Anh III", 0, 5, 24, 100},
    { "Tinh Anh II", 0, 5, 25, 100},
    { "Tinh Anh I", 0, 5, 26, 100},
    { "Cao Thủ", 0, 9, 16, 100},
    { "Đại Cao Thủ IV", 10, 19, 28, 100},
    { "Đại Cao Thủ III", 20, 29, 29, 100},
    { "Đại Cao Thủ II", 30, 39, 30, 100},
    { "Đại Cao Thủ I", 40, 49, 31, 100},
    { "Chiến Tướng", 50, 99, 27, 100},
    { "Chiến Thần", 100, 147, 32, 100},
    { "Thách Đấu", 148, 99999, 32, 1}
};


static int selectedRank = 0;
static int selectedStar = 0;
bool Mod_Rank = false;
// Hàm hiển thị menu ImGui
void ShowRankMenu()
{
  //if (Mod_Rank)
  //{
    if (ImGui::Combo("##ChonRank", &selectedRank,
        [](void*, int i, const char** out_text) { *out_text = ranks[i].name; return true; },
        nullptr, IM_ARRAYSIZE(ranks)))
    {
        // Khi chọn rank mới, reset selectedStar về LitStar của rank đó
        selectedStar = ranks[selectedRank].LitStar;
    }

        ImGui::SameLine();
        CustomCheckbox("Mod Rank", &Mod_Rank);
SaveSettings();
}


void* (*_GetMasterRoleInfo)(void*);
void* GetMasterRoleInfo(void* instance){
    if(instance != NULL && Mod_Rank){
        void* CRoleInfo = _GetMasterRoleInfo(instance);
        if(CRoleInfo)
{
        *(int*)((uint64_t)CRoleInfo + 0x34C) = selectedStar; // số lượng sao sảnh
        *(int*)((uint64_t)CRoleInfo + 0x364) = selectedStar; // số lượng sao trong bắt đầu
        *(uint8_t*)((uint64_t)CRoleInfo + 0x350) = ranks[selectedRank].IDRank; // rank hiện tại
        *(uint8_t*)((uint64_t)CRoleInfo + 0x351) = ranks[selectedRank].IDRank; // rank lịch sử cao nhất
        *(uint8_t*)((uint64_t)CRoleInfo + 0x352) = ranks[selectedRank].IDRank; // rank mùa này cao nhất
        *(int*)((uint64_t)CRoleInfo + 0x370) = 30; // số lượng mùa cao thủ trở lên
        *(int*)((uint64_t)CRoleInfo + 0x354) = ranks[selectedRank].ThackDau;// top thách đấu
        *(int*)((uint64_t)CRoleInfo + 0x358) = ranks[selectedRank].ThackDau; // top thách đấu
        *(int*)((uint64_t)CRoleInfo + 0x35C) = ranks[selectedRank].ThackDau;// top thách đấu
        return CRoleInfo;
}
    }
  return _GetMasterRoleInfo(instance);

}

void* (*_GetCurrentRankDetail)(void*);
void* GetCurrentRankDetail(void* instance) {
    if (instance != NULL && Mod_Rank) {
        void* rankdetail = _GetCurrentRankDetail(instance);
        if(rankdetail)
        {
        if (Mod_Rank)
        {
            *(int *)((uint64_t)rankdetail + 0x14) = selectedStar;
        }
        else
        {
            *(int*)((uint64_t)rankdetail + 0x14);
        }
        return rankdetail;
        }
    }
   return _GetCurrentRankDetail(instance);
}


static bool ShowUlti = false;
bool (*_ShowHeroInfo)(void *instance);
bool ShowHeroInfo(void *instance) {
    if (instance != nullptr && ShowUlti) {
        return true; 
    }
    return _ShowHeroInfo(instance);
}
void (*_ShowSkillStateInfo)(void *instance, bool bShow);
void ShowSkillStateInfo(void *instance, bool bShow) {
    if (instance != nullptr && ShowUlti) {
      bShow = true; 
    }
    _ShowSkillStateInfo(instance, bShow);
}
void (*_ShowHeroHpInfo)(void *instance, bool bShow);
void ShowHeroHpInfo(void *instance, bool bShow) {
  if (instance && ShowUlti) {
    bShow = true;
  }
  return _ShowHeroHpInfo(instance, bShow);
}

static bool ShowLsd = false; 
bool (*_IsHostProfile)(void *instance);
bool IsHostProfile(void *instance) {
    if (ShowLsd){
    return true;
}
return _IsHostProfile(instance);
}

//Show Ten Cam Chon
static bool ShowLockName = false;
void (*_InitTeamHeroList)(void* instance, void *listScript, int camp, bool isLeftList, const bool isMidPos );
void InitTeamHeroList(void* instance, void *listScript, int camp, bool isLeftList, const bool isMidPos = false) {
	if (instance != NULL && ShowLockName) { 
		isLeftList = true;
	}
	return _InitTeamHeroList(instance, listScript, camp, isLeftList, isMidPos);
}

//Show Avatar
static bool ShowAvatar = true;
int (*_checkTeamLaderGradeMax)(void *instance);
int checkTeamLaderGradeMax(void *instance){
    if (instance != NULL && ShowAvatar) { 
        return 0;
    }
   return _checkTeamLaderGradeMax(instance); 
}

static bool Bantuido = false;
bool (*_get_IsCanSell)(void *instance);
bool get_IsCanSell(void *instance){
    if(instance != NULL && Bantuido){
        return true;
    }
  return _get_IsCanSell(instance);
}


static bool Unlock120fps = false;
 const bool (*_get_Supported60FPSMode)(void *instance);
 const bool get_Supported60FPSMode(void *instance) {
    if (Unlock120fps) { 
        return true;
    } 
    return _get_Supported60FPSMode(instance);
}

const bool (*_get_Supported90FPSMode)(void *instance);
const bool get_Supported90FPSMode(void *instance) {
    if(Unlock120fps){
         return true;
    }
    return _get_Supported90FPSMode(instance);
}
 const bool (*_get_Supported120FPSMode)(void *instance);
 const bool get_Supported120FPSMode(void *instance) {
 if (Unlock120fps) { 
        return true;
    } 
    return _get_Supported120FPSMode(instance);
}

static bool HackMap = false;
void (*_LActorRoot_Visible)(void *instance, int camp, bool bVisible, const bool forceSync);
void LActorRoot_Visible(void *instance, int camp, bool bVisible, const bool forceSync = false) {
    if (instance != nullptr && HackMap) {
        if(camp == 1 || camp == 2 || camp == 110 || camp == 255) {
            bVisible = true;
        }
    } 
 return _LActorRoot_Visible(instance, camp, bVisible, forceSync);
}

static bool OnCamera = false;
float(*getZoomRate)(void* instance);
float _getZoomRate(void* instance)
{ 
    if (instance != NULL && OnCamera) 
    {   
        return getZoomRate(instance) + SetFieldOfView;
    }
    return getZoomRate(instance);
}


static bool lockcam = false;
void (*_CameraSystem_Update)(void *instance);
void CameraSystem_Update(void *instance)
{
    if (lockcam)
    {
        return;
    }
        if (instance != NULL) {
        void (*OnCameraHeightChanged)(void *) = (void (*)(void *))CameraSystem_OnCameraHeightChanged;//	private void OnCameraHeightChanged() { }
        OnCameraHeightChanged(instance);
    }
     _CameraSystem_Update(instance);
}

static bool DoiTenDai = false;
int (*CheckRoleName)(void *instance, MonoString* inputname);
int _CheckRoleName(void *instance, MonoString* inputname)
{
    if (instance != NULL)
    {
        int giatri = CheckRoleName(instance, inputname);
        if (DoiTenDai)
        {
            if (giatri == 30)
                return 0;
        }
        return giatri;
    }
    return CheckRoleName(instance, inputname);
}

MonoString* (*RemoveSpace)(void *instance, MonoString* inputname);
MonoString* _RemoveSpace(void *instance, MonoString* inputname)
{
    if (instance != NULL)
    {
        if (DoiTenDai)
            return inputname;
    }
    return RemoveSpace(instance, inputname);
}

static bool spamchat = false;
static int solanchat = 20;
void (*_SendInBattleMsg_InputChat)(const char *content, uint8_t camp);
void SendInBattleMsg_InputChat(const char *content, uint8_t camp)
{
    if (content != NULL) {
        if (spamchat) { 
           
            for (int i = 0; i < solanchat; i++) {
                _SendInBattleMsg_InputChat(content, camp);
            }
        } else {
            _SendInBattleMsg_InputChat(content, camp);
        }
    }
    return;
}


bool LogApp1z = false;
bool LogGoc = true;
void OpenAppWithBundleID(NSString *bundleID) {
    Class LSApplicationWorkspace_class = objc_getClass("LSApplicationWorkspace");
    id workspace = ((id (*)(Class, SEL))objc_msgSend)(LSApplicationWorkspace_class, sel_getUid("defaultWorkspace"));
    ((void (*)(id, SEL, NSString *))objc_msgSend)(workspace, sel_getUid("openApplicationWithBundleID:"), bundleID);
}
void OpenAppByName2(const std::string& appName) {
    NSString *bundleID = nil;

    if (appName == "Liên Quân Mobile") {
        bundleID = @"com.garena.game.kgvn";
    } else {
        NSLog(@"[LOG] Không tìm thấy app: %s", appName.c_str());
        return;
    }

    OpenAppWithBundleID(bundleID);
}

void (*old_OnEnter)(void *instance);
void OnEnter(void *instance)
{
    if(ChapToAOV == 1 || ChapToAOV == 2)
     { 
       // AntiHooK = YES; 
     }
    old_OnEnter(instance);
}

void (*_endgame)(void *instance, bool bSyncUnload, int waitingFinishState);
void endgame(void *instance, bool bSyncUnload, int waitingFinishState) {
  if (instance != NULL && ChapToAOV == 1)
     {
         return;
   }
  _endgame(instance, bSyncUnload, waitingFinishState);
}

void (*_Disconnect)(void *instance);
void Disconnect(void *instance){
if(instance != NULL && ChapToAOV == 1) {
		return;
    }
	_Disconnect(instance);
}

int ChapToAOV = 0;
void (*_CreateHeroData)(void *player, uint playerId, void* CommonData);
void CreateHeroData(void *player, uint playerId, void* CommonData)
{
    
    if ((ChapToAOV == 1 || ChapToAOV == 2) && player != NULL)
     {
        //AntiHooK = NO;
    }

    if (_CreateHeroData) {
        _CreateHeroData(player, playerId, CommonData);
    }

    if (ChapToAOV == 2) {
        dispatch_async(dispatch_get_main_queue(), ^{

           // NSURL *url = [NSURL URLWithString:@"gop100054://"];
           // [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
           
             if (LogGoc){
             LogApp1z = true;
              OpenAppByName2("Liên Quân Mobile");
             }

            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)),
                           dispatch_get_main_queue(), ^{


         if (_CreateHeroData) {
        _CreateHeroData(player, playerId, CommonData);
    }
                _exit(0);//end
          });
        });
   }
}



static void Int_Hook()
{

   static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

    espManager = new EntityManager();
    ActorLinker_enemy = new EntityManager();

    LActorRoot_get_ObjID = (int (*)(void *))Esp_LActorRoot_get_ObjID;// LActorRoot public UInt32 get_ObjID() { }
    ActorLinker_get_ObjID = (int (*)(void *))Esp_ActorLinker_get_ObjID;//ActorLinker  public UInt32 get_ObjID() { }
    ActorLinker_IsHostPlayer = (bool (*)(void *))Esp_ActorLinker_IsHostPlayer; //public bool IsHostPlayer() { }
    ActorLinker_ActorTypeDef = (int (*)(void *))Esp_ActorLinker_get_objType;//public ActorTypeDef get_objType() { }
    ActorLinker_COM_PLAYERCAMP = (int (*)(void *))Esp_ActorLinker_get_objCamp;//public COM_PLAYERCAMP get_objCamp() { }
    LActorRoot_COM_PLAYERCAMP = (int (*)(void *))Esp_LActorRoot_GiveMyEnemyCamp;//public COM_PLAYERCAMP GiveMyEnemyCamp() { }
    ActorLinker_getPosition = (Vector3(*)(void *))Esp_ActorLinker_get_position;//public Vector3 get_position() { }
    ActorLinker_get_bVisible = (bool (*)(void *))Esp_ActorLinker_get_bVisible;//public bool get_bVisible() { }
    LActorRoot_LHeroWrapper = (void *(*)(void *))Esp_LActorRoot_AsHero;//public LHeroWrapper AsHero() { }
    LObjWrapper_get_IsDeadState = (bool (*)(void *)) Esp_LObjWrapper_get_IsDeadState;
    get_speed = (int (*)(void*)) Esp_PlayerMovement_get_speed;//public virtual int get_speed() { }
    LActorRoot_get_PlayerMovement = (void* (*)(void*)) Esp_LActorRoot_get_PlayerMovement;//public PlayerMovement get_PlayerMovement() { }
    ActorLinker_ConfigId = (int (*)(void *))Esp_ActorLinker_get_ConfigId;//public uint get_ConfigId() { }

    LActorRoot_get_forward = (VInt3(*)(void *))Esp_LActorRoot_get_forward;//public VInt3 get_forward() { }
    LActorRoot_get_location = (VInt3(*)(void *))Esp_LActorRoot_get_location;//public VInt3 get_location() { }

    Reqskill = (bool (*)(void *))SkillSlot_RequestUseSkill;//public bool RequestUseSkill() { }
    Reqskill2 = (bool (*)(void *,bool))SkillSlot_ReadyUseSkill;//public bool ReadyUseSkill(bool bForceSkillUseInDefaultPosition = False) { }
    GetCurSkillSlotType = (int (*)(void *))CSkillButtonManager_ReadyUseSkill;//public SkillSlotType GetCurSkillSlotType() { }
    get_IsCharging = (bool (*)(void *))CSkillButtonManager_get_IsCharging;//public SkillSlotType GetCurSkillSlotType() { }
    RequestUseSkillSlot = (bool (*)(void *, int, int, uint, int))CSkillButtonManager_RequestUseSkillSlot;//public bool RequestUseSkillSlot(4) { }
    
    ValueLinkerComponent_get_actorHp = (int (*)(void *))Esp_ValueLinkerComponent_get_actorHp;
    ValueLinkerComponent_get_actorHpTotal = (int (*)(void *))Esp_ValueLinkerComponent_get_actorHpTotal;
    ValueLinkerComponent_get_actorSoulLever = (int (*)(void *))Esp_ValueLinkerComponent_get_actorSoulLever;//public int get_actorSoulLevel() { }
    ValuePropertyComponent_get_actorHp = (int (*)(void *))Esp_ValuePropertyComponent_get_actorHp;//public int get_actorHp() { }
    ValuePropertyComponent_get_actorHpTotal = (int (*)(void *))Esp_ValuePropertyComponent_get_actorHpTotal;//public int get_actorHpTotal() { }
    ValuePropertyComponent_get_actorSoulLevel = (int (*)(void *))Esp_ValuePropertyComponent_get_actorSoulLevel;//public int get_actorSoulLevel() { }
    ValuePropertyComponent_get_actorEp = (int (*)(void *))Esp_ValuePropertyComponent_get_actorEp;//public int get_actorEp() { }
    ValuePropertyComponent_get_actorEpTotal = (int (*)(void *))Esp_ValuePropertyComponent_get_actorEpTotal;//public int get_actorEpTotal() { }



    botro = (uintptr_t)CD_heroWrapSkillData_ex3;//	public HeroWrapSkillData heroWrapSkillData_ex3; // 0xC8
    cphutro = (uintptr_t)CD_heroWrapSkillData_5;// public HeroWrapSkillData heroWrapSkillData_5; // 0xA8
    c1 = (uintptr_t)CD_heroWrapSkillData_2; //public HeroWrapSkillData heroWrapSkillData_2; // 0x48
    c2 = (uintptr_t)CD_heroWrapSkillData_3; //public HeroWrapSkillData heroWrapSkillData_3; // 0x68
    c3 = (uintptr_t)CD_heroWrapSkillData_4; //public HeroWrapSkillData heroWrapSkillData_4; // 0x88
    Skill5OK = (uintptr_t)CD_m_commonSkillID; //private UInt32 m_commonSkillID; // 0x100

    get_VHostLogic = (void* (*)())KyriosFramework_get_hostLogic;//public static VHostLogic get_hostLogic() { }
    get_playerCenter = (void* (*)())KyriosFramework_get_playerCenter;//public static GamePlayerCenter get_playerCenter() { }

    old_RefreshHeroPanel = (void (*)(void*, bool, bool, bool))UL_RefreshHeroPanel;//HeroSelectNormalWindow public void RefreshHeroPanel(bool bForceRefreshAddSkillPanel = False, bool bRefreshSymbol = True, bool bRefreshHeroSkill = True) { }

    //PlayersList = (List<void *> *(*)(void *)) ((uintptr_t)getRealOffset(0x4AD8B30));//public List<PlayerBase> GetAllPlayers() { }

    get_actorManager = (void* *(*)())KyriosFramework_get_actorManager;
    GetAwakeSkinData = (void *(*)(uint32_t))Evo_GetAwakeSkinData;//public static COMDT_HERO_SKIN_WAKE_DATA GetAwakeSkinData(uint wakeSkinID) { }
    AsHero = (uintptr_t(*)(void *))Esp_ActorLinker_AsHero;

    //_SetPlayerName = (monoString* (*)(uintptr_t, monoString *, monoString *, bool, monoString *))getRealOffset(0x5B4DF00);
   // SetVisibleOffset = methodAccessSystem2.getClass("NucleusDrive.Logic", "LVActorLinker").getMethod("SetVisible", 3);
   //oooffff(SetVisibleOffset, LActorRoot_Visible,_LActorRoot_Visible);
   
   HookPatch(ENCRYPTOFFSET("0x4AD9F60"), GetPlayer, _GetPlayer);//public PlayerBase GetPlayer(uint inPlayerID) { }
  // HookPatch(ENCRYPTOFFSET("0x40CBD24"), _IsAtMyTeam, IsAtMyTeam);//public bool IsAtMyTeam(int playerId, int configId) { }
   HookPatch(ENCRYPTOFFSET("0x5C6D6F0"), BattleStatic, _BattleStatic);//class LobbyLogic / public void UpdateLogic(int delta) { }
   HookPatch(ENCRYPTOFFSET("0x52C36DC"), GetMasterRoleInfo, _GetMasterRoleInfo);
   HookPatch(ENCRYPTOFFSET("0x4CCE744"), GetCurrentRankDetail, _GetCurrentRankDetail);
 
   HookPatch(CameraSystem_GetZoomRate, _getZoomRate, getZoomRate);//public Single GetZoomRate() { }
   HookPatch(CameraSystem_Updates, CameraSystem_Update, _CameraSystem_Update);//class CameraSystem / private Void Update() { }
   HookPatch(LVActorLinker_SetVisible, LActorRoot_Visible, _LActorRoot_Visible);//public Boolean SetVisible(COM_PLAYERCAMP camp, Boolean bVisible, Boolean forceSync) { }
   
   HookPatch(CPlayerProfile_get_IsHostProfile, IsHostProfile, _IsHostProfile);//public Boolean get_IsHostProfile() { }
   HookPatch(RelaySvrConnector_Disconnect, Disconnect, _Disconnect);//RelaySvrConnector / public Void Disconnect() { }
   HookPatch(LFramework_EndGame, endgame, _endgame);//public Void EndGame(Boolean bSyncUnload, eWaitGameFinishState waitingFinishState) { }

   HookPatch(PersonalButton_IsOpen, IsOpen, old_IsOpen);//public static bool IsOpen() { }
   HookPatch(PersonalButton_get_PersonalBtnId, get_PersonalBtnId, old_get_PersonalBtnId);//private static int get_PersonalBtnId() { }
   
   HookPatch(HeroInfoPanel_ShowHeroInfo, ShowHeroInfo, _ShowHeroInfo);//private Void ShowHeroInfo(PoolObjHandle<T0> actor, Boolean bShow) { }
   HookPatch(MiniMapHeroInfo_ShowSkillStateInfo, ShowSkillStateInfo, _ShowSkillStateInfo);//public Void ShowSkillStateInfo(Boolean bShow) { }
   HookPatch(MiniMapHeroInfo_ShowHeroHpInfo, ShowHeroHpInfo, _ShowHeroHpInfo);//public Void ShowHeroHpInfo(Boolean bShow) { }

   HookPatch(CUIUtility_RemoveSpace, _RemoveSpace,RemoveSpace);//public static String RemoveSpace(String str) { }
   HookPatch(Utility_CheckRoleName, _CheckRoleName, CheckRoleName);//public static NameResult CheckRoleName(String inputName) { }
   HookPatch(InBattleMsgNetCore_SendInBattleMsg_InputChat, SendInBattleMsg_InputChat, _SendInBattleMsg_InputChat);//public static Void SendInBattleMsg_InputChat(String content, Byte camp) { }

   HookPatch(CItem_get_IsCanSell, get_IsCanSell, _get_IsCanSell);//CItem / public override Boolean get_IsCanSell() { }

   HookPatch(SkillControlIndicator_GetUseSkillDirection, GetUseSkillDirection, _GetUseSkillDirection);

   HookPatch(UL_unpackSkin, unpack, old_unpack);
   HookPatch(UL_IsCanUseSkin, IsCanUseSkin, old_IsCanUseSkin);
   HookPatch(UL_OnClickSelectHeroSkin, OnClickSelectHeroSkin, old_OnClickSelectHeroSkin);
   HookPatch(UL_IsHaveHeroSkin, IsHaveHeroSkin, old_IsHaveHeroSkin);
   HookPatch(UL_GetHeroWearSkinId, GetHeroWearSkinId, old_GetHeroWearSkinId);//GetHeroWearSkinId
   HookPatch(Evo_IsAwakeSkin, IsAwakeSkin, _IsAwakeSkin); //AwakeSkinHelper
   HookPatch(Evo_unpack, unpack1, _unpack1);//COMDT_CHOICEHERO

    //Show Avatar && Hiện Tên Cấm Chọn
    HookPatch(HeroSelectBanPickWindow_InitTeamHeroList, InitTeamHeroList, _InitTeamHeroList);//HeroSelectBanPickWindow / 	public Void InitTeamHeroList(CUIListScript listScript, COM_PLAYERCAMP camp, Boolean isLeftList, Boolean isMidPos) { }
    HookPatch(CMatchingSystem_checkTeamLaderGradeMax, checkTeamLaderGradeMax, _checkTeamLaderGradeMax);//CMatchingSystem / private Int32 checkTeamLaderGradeMax(Int32 MapType) { }
	
	HookPatch(HudComponent3D_SetPlayerName, _SetPlayerName, SetPlayerName);//public Void SetPlayerName(String playerName, String prefixName, Boolean isGuideLevel, String customName) { }
	
    HookPatch(SkillSlot_LateUpdate, Skslot, _Skslot);//class SkillSlot / public void LateUpdate(int nDelta) { }
    HookPatch(SkillControlIndicator_LateUpdate, _LateUpdateBug, LateUpdateBug);

    HookPatch(CSkillButtonManager_LateUpdate, SkillButtonManager_LateUpdate, _SkillButtonManager_LateUpdate);
    // H O O K  ESP
    HookPatch(adr_LActorRoot_UpdateLogic, LActorRoot_UpdateLogic, old_LActorRoot_UpdateLogic);//LActorRoot / public Void UpdateLogic(Int32 delta) { }
    HookPatch(ActorLinker_DestroyActor, ActorLinker_ActorDestroy, old_ActorLinker_ActorDestroy);//Aclink / public void DestroyActor() { }
    HookPatch(LActorRoot_DestroyActor, LActorRoot_ActorDestroy, old_LActorRoot_ActorDestroy);//LActorRoot / public void DestroyActor(bool bTriggerEvent) { }

	//Show CD Name
    HookPatch(adr_ActorLinker_Update, AUpdate, old_Update);//ActorLinker / public Void Update() { }
    
    HookPatch(GameSettings_get_Supported60FPSMode, get_Supported60FPSMode, _get_Supported60FPSMode);//public static Boolean get_Supported60FPSMode() { }
    HookPatch(GameSettings_get_Supported90FPSMode, get_Supported90FPSMode, _get_Supported90FPSMode);//public static Boolean get_Supported90FPSMode() { }
    HookPatch(GameSettings_get_Supported120FPSMode, get_Supported120FPSMode, _get_Supported120FPSMode);//public static Boolean get_Supported120FPSMode() { }
    HookPatch(BattleStatistic_CreateHeroData, CreateHeroData , _CreateHeroData);//private Void CreateHeroData(UInt32 playerId, ref COMDT_SETTLE_COMMON_DATA CommonData) { }
    HookPatch(PVPLoadingView_OnEnter, OnEnter, old_OnEnter);//PVPLoadingView / protected override Void OnEnter() { }

    //PVPLoadingView / protected override Void OnEnter() { }
    PatchOffset("Frameworks/UnityFramework.framework/UnityFramework", PVPLoadingView_ShowRank, "1F2003D5"); // rank + 0x1320 | 1F0109EBE100005448 Hex 
    //public Void updateTalentSkillCD(Player curPlayer) { } + 2C4
    PatchOffset("Frameworks/UnityFramework.framework/UnityFramework", HeroItem_updateTalentSkillCD, "1F2003D5"); // btro + 0x21C

    });
}


- (void)viewDidLoad {
    [super viewDidLoad];

    // Init NSUserDefaults
    saveSetting = [NSUserDefaults standardUserDefaults];
    LoadSettings();

    // Hook + load online
    Int_Hook();
    loadOptionsOnline();

    // Metal setup
    self.mtkView.device = self.device;
    self.mtkView.delegate = self;
    self.mtkView.clearColor = MTLClearColorMake(0, 0, 0, 0);
    self.mtkView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    self.mtkView.clipsToBounds = YES;
}

#pragma mark - Interaction

- (void)updateIOWithTouchEvent:(UIEvent *)event
{
    UITouch *anyTouch = event.allTouches.anyObject;
    CGPoint touchLocation = [anyTouch locationInView:self.view];
    ImGuiIO &io = ImGui::GetIO();
    io.MousePos = ImVec2(touchLocation.x, touchLocation.y);

    BOOL hasActiveTouch = NO;
    for (UITouch *touch in event.allTouches)
    {
        if (touch.phase != UITouchPhaseEnded && touch.phase != UITouchPhaseCancelled)
        {
            hasActiveTouch = YES;
            break;
        }
    }
    io.MouseDown[0] = hasActiveTouch;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self updateIOWithTouchEvent:event];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self updateIOWithTouchEvent:event];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self updateIOWithTouchEvent:event];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self updateIOWithTouchEvent:event];
}


void DrawAppInfo_Real()
{

    // ===== THIẾT BỊ =====
    struct utsname sys;
    uname(&sys);
    NSString *machine =
        [NSString stringWithUTF8String:sys.machine];

    // 👉 HÀM CỦA BẠN
    NSString *deviceName = GetiPhoneModelName(machine);

    // ===== PIN =====
    UIDevice *device = [UIDevice currentDevice];
    device.batteryMonitoringEnabled = YES;
    int battery = (int)(device.batteryLevel * 100);
    bool charging =
        (device.batteryState == UIDeviceBatteryStateCharging ||
         device.batteryState == UIDeviceBatteryStateFull);

    // ===== THỜI GIAN =====
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"vi_VN"];
    formatter.dateFormat = @"EEEE, dd/MM/yyyy | HH:mm:ss";
    NSString *timeString = [formatter stringFromDate:[NSDate date]];

    // ===== IMGUI TEXT (GIỮ NGUYÊN KIỂU VIẾT) =====
    ImGui::Text("Thiết Bị:");
    ImGui::SameLine();
    ImGui::TextColored(ImVec4(1,0,1,1), "%s", deviceName.UTF8String);

    // 👉 DÒNG MỚI – THỜI GIAN
    ImGui::Text("Thời Gian:");
    ImGui::SameLine();
    ImGui::TextColored(ImVec4(0,1,1,1), "%s", timeString.UTF8String);

    ImGui::Text("Pin:");
    ImGui::SameLine();
    ImGui::TextColored(ImVec4(1,1,0,1), "%d%%", battery);
    ImGui::SameLine();
    ImGui::TextColored(
        charging ? ImVec4(0,1,0,1) : ImVec4(1,0,0,1),
        "%s", charging ? " Đang Sạc" : " Không Sạc"
    );
}



#pragma mark - MTKViewDelegate

- (void)drawInMTKView:(MTKView*)view
{
    hideRecordTextfield.secureTextEntry = StreamerMode;
    ImGuiIO& io = ImGui::GetIO();
    io.DisplaySize.x = view.bounds.size.width;
    io.DisplaySize.y = view.bounds.size.height;

     CGFloat framebufferScale = view.window.screen.scale ?: UIScreen.mainScreen.scale;
   if (iPhonePlus) {
        io.DisplayFramebufferScale = ImVec2(2.60, 2.60);
    } else {
        io.DisplayFramebufferScale = ImVec2(framebufferScale, framebufferScale);
     }

    io.DeltaTime = 1 / float(view.preferredFramesPerSecond ?: 120);
    
    id<MTLCommandBuffer> commandBuffer = [self.commandQueue commandBuffer];

        if (MenDeal == true) 
        {
            [self.view setUserInteractionEnabled:YES];
            [self.view.superview setUserInteractionEnabled:YES];
            [menuTouchView setUserInteractionEnabled:YES];
        } 
        else if (MenDeal == false) 
        {
            [self.view setUserInteractionEnabled:NO];
            [self.view.superview setUserInteractionEnabled:NO];
            [menuTouchView setUserInteractionEnabled:NO];
        }

        MTLRenderPassDescriptor* renderPassDescriptor = view.currentRenderPassDescriptor;
        if (renderPassDescriptor != nil)
        {
            id <MTLRenderCommandEncoder> renderEncoder = [commandBuffer renderCommandEncoderWithDescriptor:renderPassDescriptor];
            [renderEncoder pushDebugGroup:@"ImGui Jane"];

            ImGui_ImplMetal_NewFrame(renderPassDescriptor);
            ImGui::NewFrame();
            
            //ImFont* font = ImGui::GetFont();
            //font->Scale = 16.f / font->FontSize;
            
ImVec2 display = ImGui::GetIO().DisplaySize;

ImGui::SetNextWindowPos(
    ImVec2(display.x * 0.5f, display.y * 0.5f),
    ImGuiCond_FirstUseEver,
    ImVec2(0.5f, 0.5f) // pivot
);

ImGui::SetNextWindowSize(ImVec2(550, 335), ImGuiCond_FirstUseEver);
            

            // Tải texture từ Base64 trong Logo.h
            static id<MTLTexture> bg_nmkios = nil;
            if (bg_nmkios == nil) 
            {
                NSString* base64String = nmkios; // Sử dụng macro từ Logo.h
                std::string base64_std_string([base64String UTF8String]);
                bg_nmkios = LoadTextureFromBase64(self.device, base64_std_string);
            }  


            if (MenDeal == true)
            {                

                char* Gnam = (char*)[[NSString stringWithFormat:@"%@",NSSENCRYPT("  NmkiOSVN")]
                cStringUsingEncoding:NSUTF8StringEncoding];
                ImGui::Begin(Gnam, &MenDeal, ImGuiWindowFlags_NoResize | ImGuiWindowFlags_NoTitleBar | ImGuiWindowFlags_NoScrollbar);

                const ImVec2 pos = ImGui::GetWindowPos();
                ImU32 colorRect = IM_COL32(77, 77, 77, 50);   // Rectangle color (RGB: 82, 100, 0
                ImGui::GetWindowDrawList()->AddRectFilled(
                ImVec2(pos.x + 5,pos.y +5), 
                ImVec2(pos.x + 495, pos.y + 35), 
                colorRect);

                ImGui::SetCursorPosY(ImGui::GetCursorPosY() + 3);  // Giảm khoảng cách dòng    
                ImGui::SetCursorPosX(ImGui::GetCursorPosX() + 27);  // Giảm khoảng cách dòng

                ImGui::PushFont(FontThemes);
                float windowWidth = ImGui::GetWindowSize().x;
                float textWidth = ImGui::CalcTextSize(Gnam).x;
                ImGui::SetCursorPosX((windowWidth - textWidth) * 0.5f);
                ImGui::Text("%s", Gnam);
                ImGui::PopFont();


                ImDrawList* draw = ImGui::GetWindowDrawList();
                // Lấy thời gian hiện tại tính bằng giây
                float time = ImGui::GetTime();
                int currentDot = static_cast<int>(floor(time)) % 3;  // Xác định vị trí chấm phát sáng (0, 1, hoặc 2)

                 // Màu tối cho trạng thái chưa phát sáng
                 ImColor darkColors[3] = { ImColor(100, 30, 30), ImColor(100, 70, 30), ImColor(30, 100, 30) }; // Màu tối mờ

                 // Màu phát sáng kiểu neon cho từng chấm
                 ImColor glowColors[3] = { ImColor(255, 50, 50, 200), ImColor(255, 220, 100, 200), ImColor(130, 255, 130, 200) }; // Màu phát sáng đậm, hơi trong suốt

                  //Vẽ các chấm, kiểm tra xem có phải chấm đang phát sáng không
                  draw->AddCircleFilled(ImVec2(pos.x + 20, pos.y + 20), 8, currentDot == 0 ? glowColors[0] : darkColors[0], 360);
                  draw->AddCircleFilled(ImVec2(pos.x + 41, pos.y + 20), 8, currentDot == 1 ? glowColors[1] : darkColors[1], 360);
                  draw->AddCircleFilled(ImVec2(pos.x + 62, pos.y + 20), 8, currentDot == 2 ? glowColors[2] : darkColors[2], 360);

// 1. Tính toán vị trí để nút luôn nằm bên phải
float buttonSize = 50.0f;     // Kích thước nút (vuông)
float marginRight = 5.0f;     // Khoảng cách từ mép phải vào
float posX = ImGui::GetWindowWidth() - buttonSize - marginRight;

// 2. Thiết lập vị trí con trỏ (Y = -2 như cũ của bạn)
ImGui::SetCursorPos(ImVec2(posX, -2));

// 3. Đẩy style (Trong suốt và không viền)
ImGui::PushStyleColor(ImGuiCol_Button, ImVec4(0, 0, 0, 0));
ImGui::PushStyleColor(ImGuiCol_ButtonHovered, ImVec4(0, 0, 0, 0));
ImGui::PushStyleColor(ImGuiCol_ButtonActive, ImVec4(0, 0, 0, 0));
ImGui::PushStyleVar(ImGuiStyleVar_FrameBorderSize, 0.0f);
ImGui::PushStyleVar(ImGuiStyleVar_FramePadding, ImVec2(0, 6)); 

// 4. Vẽ nút Power
if (ImGui::Button(ICON_FA_POWER_OFF, ImVec2(buttonSize, buttonSize))) {
    MenDeal = false;
}

                   ImGui::PopStyleVar(); 
                   // Khôi phục màu sắc ban đầu
                   ImGui::PopStyleColor(3);

           ImDrawList *draw_list = ImGui::GetWindowDrawList();
           ImVec4 activeColor   = ImVec4(0.17f, 0.36f, 0.62f, 1.0f);
            ImVec4 inactiveColor = ImVec4(0.173f, 0.290f, 0.439f, 1.0f);
           ImVec4 activeLineColor = ImVec4(0, 0, 0, 0);  // Thanh Ngang

         
           ImGui::SetCursorPos({5, 40});
           ImGui::BeginChild("##LuxH7", ImVec2(120, -1), false,
                  ImGuiWindowFlags_NoScrollbar);

ImVec2 iconThanhNgang = ImVec2(100, 70);
ImVec2 cursorPosNgang = ImGui::GetCursorScreenPos(); 

draw->AddImage((void*)CFBridgingRetain(bg_nmkios), cursorPosNgang, ImVec2(cursorPosNgang.x + iconThanhNgang.x, cursorPosNgang.y + iconThanhNgang.y)); 

// Thay vì dùng startPos và iconSize không tồn tại:
ImGui::SetCursorScreenPos(ImVec2(cursorPosNgang.x, cursorPosNgang.y + iconThanhNgang.y + 10));

// ===== MENU BUTTONS =====
const float paddingX = 6.0f;

ImGui::SetCursorPosX(paddingX);
if (MenuButton(ICON_FA_HOME " HOME", tab == 1)) tab = 1;

ImGui::SetCursorPosX(paddingX);
if (MenuButton(ICON_FA_GAMEPAD " EXTRA", tab == 2)) tab = 2;

ImGui::SetCursorPosX(paddingX);
if (MenuButton(ICON_FA_FOLDER_OPEN " SKINS", tab == 3)) tab = 3;

ImGui::SetCursorPosX(paddingX);
if (MenuButton(ICON_FA_CROSSHAIRS " AIMSKILL", tab == 4)) tab = 4;

ImGui::SetCursorPosX(paddingX);
if (MenuButton(ICON_FA_SKULL_CROSSBONES " AUTO", tab == 5)) tab = 5;

ImGui::EndChild();
          ImGui::SameLine();

         ImGui::SetCursorPos({133, 40});
         ImGui::BeginChild("##Khungmenu", ImVec2(-1, 0), true);
          switch (tab) {

          case 1: {

          ImGui::BeginGroup();
          CustomCheckbox("Map Hack", &HackMap);
SaveSettings();
          CustomCheckbox("Bật Camera", &OnCamera);
SaveSettings();
          ImGui::EndGroup();

          ImGui::SameLine();

          ImGui::BeginGroup();
          CustomCheckbox("Hiện Unti", &ShowUlti);
SaveSettings();
          CustomCheckbox("Khoá Camera", &lockcam);
SaveSettings();
          ImGui::EndGroup();

          ImGui::SameLine();
           
          ImGui::BeginGroup();
          CustomCheckbox("Cooldown", &ShowCD);
SaveSettings();
          CustomCheckbox("Live Mode", &StreamerMode);
SaveSettings();
          ImGui::EndGroup();
          
ImGui::PushItemWidth(340);
// Vẽ thanh Slider
if (ImGui::SliderFloat("##Camera", &SetFieldOfView, 0.0f, 10.0f, "Độ Cao Camera : %.3f", 2)) {
    // Đoạn này để trống, chỉ để nhận giá trị thay đổi trực tiếp trong game
}

// CHỈ LƯU khi người dùng thả tay ra khỏi thanh kéo
if (ImGui::IsItemDeactivatedAfterEdit()) {
    SaveSettings();
}
ImGui::PopItemWidth();

ImGui::Spacing(); 
ImGui::Separator();
				
                
		if (ImGui::Button("Telegram Group")) {
         // Mở đường link (trên iOS hoặc macOS, dùng hệ thống gọi mở URL)
           NSString *urlString = NSSENCRYPT("https://t.me/minhkhangchannel");
           NSURL *url = [NSURL URLWithString:urlString];
          if ([[UIApplication sharedApplication] canOpenURL:url]) {
         [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
          }
        }

         ImGui::SameLine();

        if (ImGui::Button("Telegram Admin")) {
         NSString *urlString = NSSENCRYPT("https://t.me/Nmkiosvn/");
         NSURL *url = [NSURL URLWithString:urlString];
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
         }
        }

         ImGui::SameLine();

        if (ImGui::Button("Zalo Admin")) {
        // Mở đường link (trên iOS hoặc macOS, dùng hệ thống gọi mở URL)
         NSString *urlString = NSSENCRYPT("https://zalo.me/0869641898");
         NSURL *url = [NSURL URLWithString:urlString];
         if ([[UIApplication sharedApplication] canOpenURL:url]) {
         [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
            }
          }

           DrawAppInfo_Real();


          } 
          break;
            case 2: {  

                ImGui::BeginGroup();
                CustomCheckbox("Hiện Lịch Sử Đấu", &ShowLsd);
SaveSettings();
                CustomCheckbox("Hiện Khung Rank", &ShowRank);
SaveSettings();
                CustomCheckbox("Hiện Bổ Trợ", &ShowBoTroz);
SaveSettings();
                //CustomCheckbox("Hiện Cấm Chọn", &ShowLockName);
SaveSettings();
                //CustomCheckbox("Bán Vật Phẩm", &Bantuido);
SaveSettings();
                ImGui::EndGroup();
                
                ImGui::SameLine(180);

                ImGui::BeginGroup();
                CustomCheckbox("Unlock 120FPS",&Unlock120fps);
SaveSettings();
                CustomCheckbox("Bug Skill", &activebug);
SaveSettings();
                //ImGui::SameLine();
               // HelpMarker("Keera | Nakroth | Slimz");
                //CustomCheckbox("Spam Chat x20", &spamchat);
//SaveSettings();
                
                CustomCheckbox("Huỷ Trận Đấu", &AutoWinz);
                //ImGui::SameLine();
             //   HelpMarker("Huỷ Trận Rủi Ro \nKhoá Nhiều Năm \nBật Phút Thứ 3 Trận Đấu !");

                //CustomCheckbox("Đổi Tên Dài", &DoiTenDai);
                //ImGui::SameLine();
                //HelpMarker("Mở Lên Khie Muốn Đổi Tên Dài \nSau Khi Ghi Xong Tên Cần \nTắt Chức Năng Này Để Có Thể \nĐổi Tên Thành Công");

                ImGui::EndGroup();  

                ImGui::Spacing();
             }
            break;
            case 3: {

                CustomCheckbox("Mở Khoá Tất Cả Skin", &unlockskin);
                ImGui::SameLine();
                DrawHeroSkinInfo();

                ImGui::PushItemWidth(260);
                DrawModButton();
                DrawModNotify();
                const char* LinhWhenOptions[] = {"[ Mặc Định ]", "Trang Phục Lính Conan", "Trang Phục Lính Yêu Tinh","Trang Phục Lính Cinnamon Dessert"};
                ImGui::Combo("Lính", &SkinLinh, LinhWhenOptions, IM_ARRAYSIZE(LinhWhenOptions));
SaveSettings();
                ImGui::PopItemWidth();
//                ModTopLQ();
                ShowRankMenu();
                }
            break;
            case 4: {
                CustomCheckbox("Aim Skill", &AimSkill);
SaveSettings();
                //ImGui::SameLine();
                //HelpMarker("Aim Đón Gió Tất Cả Tướng");
                const char* aimWhenOptions[] = {"Aim Theo Tỉ Lệ % Máu", "Aim Theo Tỉ Lệ Máu Thấp", "Aim Theo Địch Ở Gần Nhất", "Aim Theo Địch Gần Tia Nhất"};
                 ImGui::Combo("Chọn Aimbot", &aimType, aimWhenOptions, IM_ARRAYSIZE(aimWhenOptions));
                 const char* drawOptions[] = {"Không", "Luôn Luôn", "Khi Xem"};
                 ImGui::Combo("Vẽ Vật Thể", &drawType, drawOptions, IM_ARRAYSIZE(drawOptions));
SaveSettings();
            }
            break;
            case 5: {

               // CustomCheckbox("Trừng Trị", &autott);
               // ImGui::SameLine();

                //CustomCheckbox("Bùa Xanh,Đỏ", &onlymt);
                //ImGui::SameLine();
                //CustomCheckbox("Rồng,Caser", &rongta);

// --- BỘC PHÁ ---
if (CustomCheckbox("Bộc Phá", &autobocpha)) {
    SaveSettings(); 
}
ImGui::SameLine();
ImGui::PushItemWidth(220);
if (ImGui::SliderFloat("##lol", &maubotro , 0.0f , 100.0f,"Địch Dưới %.2f%% Máu")) {
    if (ImGui::IsItemDeactivatedAfterEdit()) SaveSettings();
}
ImGui::PopItemWidth();

// --- BĂNG SƯƠNG ---
//if (CustomCheckbox("Băng Sương", &bangsuongz)) {
//    SaveSettings();
//}
//ImGui::SameLine();
//ImGui::PushItemWidth(80);
//if (ImGui::SliderFloat("##cxd", &mauphutro , 0.0f , 100.0f,"Mình Dưới %.2f%% Máu")) {
//    if (ImGui::IsItemDeactivatedAfterEdit()) SaveSettings();
//}
//ImGui::PopItemWidth();

// --- CẤP CỨU ---
//if (CustomCheckbox("Cấp Cứu", &capcuuz)) {
//    SaveSettings();
//}
//ImGui::SameLine();
//ImGui::PushItemWidth(80);
//if (ImGui::SliderFloat("##bcc", &maucapcuu , 0.0f , 100.0f,"Mình Dưới %.2f%% Máu")) {
//    if (ImGui::IsItemDeactivatedAfterEdit()) SaveSettings();
//}
//ImGui::PopItemWidth();

// --- HỒI MÁU ---
if (CustomCheckbox("Hồi Máu", &hoimau)) {
    SaveSettings();
}
ImGui::SameLine();
ImGui::PushItemWidth(220);
if (ImGui::SliderFloat("##bccm", &mauhoimau , 0.0f , 100.0f,"Mình Dưới %.2f%% Máu")) {
    if (ImGui::IsItemDeactivatedAfterEdit()) SaveSettings();
}
ImGui::PopItemWidth();
            }
          }

              ImGui::EndChild();
                
          //======================== 
                ImGui::End(); 
               
            }



            ImDrawList* draw_list = ImGui::GetBackgroundDrawList();
          //  CallMe();
          //  DrawBugSkill(draw_list);
            DrawESP(draw_list);
            

if(ShowRank){ if(ShowRank_active == NO){
 ActiveCodePatch("Frameworks/UnityFramework.framework/UnityFramework", PVPLoadingView_ShowRank , "1F2003D5");
 } ShowRank_active = YES;
    } else { if(ShowRank_active == YES){
  DeactiveCodePatch("Frameworks/UnityFramework.framework/UnityFramework", PVPLoadingView_ShowRank , "1F2003D5");
  } ShowRank_active = NO;
}

if(ShowBoTroz){ if(ShowBoTroz_active == NO){
  ActiveCodePatch("Frameworks/UnityFramework.framework/UnityFramework", HeroItem_updateTalentSkillCD , "1F2003D5");
  } ShowBoTroz_active = YES;
    } else { if(ShowBoTroz_active == YES){
 DeactiveCodePatch("Frameworks/UnityFramework.framework/UnityFramework", HeroItem_updateTalentSkillCD , "1F2003D5");
  } ShowBoTroz_active = NO;
 }



ImGuiStyle& style = ImGui::GetStyle();

// ================== BO GÓC – CẢM GIÁC MỀM ==================
style.WindowRounding    = 8.0f;
style.ChildRounding     = 6.0f;
style.FrameRounding     = 6.0f;
style.PopupRounding     = 6.0f;
style.ScrollbarRounding = 8.0f;
style.GrabRounding      = 6.0f;

// ================== KÍCH THƯỚC – MƯỢT ==================
style.FramePadding   = ImVec2(8, 6);
style.ItemSpacing    = ImVec2(10, 8);
style.ItemInnerSpacing = ImVec2(8, 6);
style.ScrollbarSize  = 18.0f;
style.GrabMinSize    = 14.0f;

// ================== NỀN TRONG SUỐT ==================
ImVec4 bgWindow      = ImVec4(0.10f, 0.10f, 0.10f, 0.72f); // nền chính
ImVec4 bgChild       = ImVec4(0.12f, 0.12f, 0.12f, 0.35f); // nền trong suốt
ImVec4 bgPopup       = ImVec4(0.12f, 0.12f, 0.12f, 0.85f);

// ================== MÀU ĐỎ CHỦ ĐẠO ==================
ImVec4 redMain       = ImVec4(0.85f, 0.18f, 0.18f, 1.0f);
ImVec4 redHover      = ImVec4(0.95f, 0.25f, 0.25f, 1.0f);
ImVec4 redActive     = ImVec4(0.75f, 0.12f, 0.12f, 1.0f);

// ================== MÀU CƠ BẢN ==================
ImVec4 textMain      = ImVec4(0.95f, 0.95f, 0.95f, 1.0f);
ImVec4 textDisabled  = ImVec4(0.55f, 0.55f, 0.55f, 1.0f);
ImVec4 borderColor   = ImVec4(0.85f, 0.18f, 0.18f, 0.35f);

// ================== GÁN MÀU ==================
style.Colors[ImGuiCol_WindowBg]        = bgWindow;
style.Colors[ImGuiCol_ChildBg]         = bgChild;
style.Colors[ImGuiCol_PopupBg]         = bgPopup;

style.Colors[ImGuiCol_Border]          = borderColor;
style.Colors[ImGuiCol_BorderShadow]    = ImVec4(0,0,0,0);

style.Colors[ImGuiCol_Text]             = textMain;
style.Colors[ImGuiCol_TextDisabled]     = textDisabled;

style.Colors[ImGuiCol_FrameBg]          = ImVec4(0.18f,0.18f,0.18f,0.65f);
style.Colors[ImGuiCol_FrameBgHovered]   = ImVec4(0.22f,0.22f,0.22f,0.75f);
style.Colors[ImGuiCol_FrameBgActive]    = ImVec4(0.25f,0.25f,0.25f,0.85f);

style.Colors[ImGuiCol_Button]           = ImVec4(0.20f,0.20f,0.20f,0.75f);
style.Colors[ImGuiCol_ButtonHovered]    = redHover;
style.Colors[ImGuiCol_ButtonActive]     = redActive;

style.Colors[ImGuiCol_CheckMark]        = redMain;
style.Colors[ImGuiCol_SliderGrab]       = redMain;
style.Colors[ImGuiCol_SliderGrabActive] = redHover;

style.Colors[ImGuiCol_ScrollbarBg]      = ImVec4(0.12f,0.12f,0.12f,0.40f);
style.Colors[ImGuiCol_ScrollbarGrab]    = ImVec4(0.85f,0.18f,0.18f,0.65f);
style.Colors[ImGuiCol_ScrollbarGrabHovered]
                                      = ImVec4(0.95f,0.25f,0.25f,0.85f);
style.Colors[ImGuiCol_ScrollbarGrabActive]
                                      = ImVec4(0.75f,0.12f,0.12f,1.0f);

style.Colors[ImGuiCol_Separator]        = ImVec4(0.85f,0.18f,0.18f,0.35f);
style.Colors[ImGuiCol_SeparatorHovered] = redHover;
style.Colors[ImGuiCol_SeparatorActive]  = redActive;


            ImGui::Render();
            ImDrawData* draw_data = ImGui::GetDrawData();
            ImGui_ImplMetal_RenderDrawData(draw_data, commandBuffer, renderEncoder);
          
            [renderEncoder popDebugGroup];
            [renderEncoder endEncoding];

            [commandBuffer presentDrawable:view.currentDrawable];
        }

        [commandBuffer commit];
}

- (void)mtkView:(MTKView*)view drawableSizeWillChange:(CGSize)size
{}


void DrawESP(ImDrawList* draw)
{
    if (espManager->enemies->empty())
    {
        previousEnemyPositions.clear();
        return;
    }


    int lowestHp = 1000000000;
    int lowestHp2 = 1000000000;
    float lowestHpPercent = 1000000000;
    float closestEnemyDistance = 1000000000;
    float closestEnemyDistanceView = 1000000000;
   
    void* Entity = NULL;
    void* EnemyFlo = NULL;

    void* myLinker = espManager->MyPlayer;
    if (!myLinker) return;

    Vector3 myPos = ActorLinker_getPosition(myLinker);

    for (int i = 0; i < espManager->enemies->size(); i++)
    {
        void* EnemyRoot = (*espManager->enemies)[i]->object;
        if (!EnemyRoot) continue;

        void* LObjWrapper = *(void**)((uint64_t)EnemyRoot + Esp_LActorRoot_ActorControl);
        if (LObjWrapper_get_IsDeadState(LObjWrapper)) continue;

        void* ValueProperty = *(void**)((uint64_t)EnemyRoot + Esp_LActorRoot_ValueComponent);
        void* EnemyLinker = (*ActorLinker_enemy->enemies)[i]->object;
        if (!EnemyLinker) continue;

        void *PlayerMovement = LActorRoot_get_PlayerMovement(EnemyRoot);
        int speed = get_speed(PlayerMovement);
        
        if (Camera::get_main() == nullptr) continue;

        // ================== POSITION ==================
        Vector3 EnemyPos;
        VInt3 NowLocation = LActorRoot_get_location(EnemyRoot);
        VInt3 forwardEnemy = LActorRoot_get_forward(EnemyRoot);
        float speedEnemy = (float)speed/1000.0f;
        bool isVisible = ActorLinker_get_bVisible(EnemyLinker);
        if (isVisible)
        {
            EnemyPos = ActorLinker_getPosition(EnemyLinker);
            previousEnemyPositions[(uintptr_t)EnemyRoot] = EnemyPos;
        }
        else
        {
            EnemyPos = VInt2Vector(NowLocation, forwardEnemy);
            if (previousEnemyPositions.find((uintptr_t)EnemyRoot) == previousEnemyPositions.end())
                previousEnemyPositions[(uintptr_t)EnemyRoot] = EnemyPos;

            EnemyPos = Lerp(previousEnemyPositions[(uintptr_t)EnemyRoot], EnemyPos, 0.2f);
            previousEnemyPositions[(uintptr_t)EnemyRoot] = EnemyPos;
        }

        ImVec2 rootPos_Vec2 = GetPlayerPosition(EnemyPos);
        int EnemyHp = ValuePropertyComponent_get_actorHp(ValueProperty);
        int EnemyHpTotal = ValuePropertyComponent_get_actorHpTotal(ValueProperty);
        float EpPercent = (float)EnemyHp/EnemyHpTotal;

        int EnemyEp = ValuePropertyComponent_get_actorEp(ValueProperty);
        int EnemyEpTotal = ValuePropertyComponent_get_actorEpTotal(ValueProperty);
        int GetLever = ValuePropertyComponent_get_actorSoulLevel(ValueProperty);
        float distanceToMe = Vector3::Distance(myPos, EnemyPos);
        ImVec2 myScreenPos = GetPlayerPosition(myPos);
        float distancess = ClosestDistanceEnemy(myPos, EnemyPos, CurrentPosition);
        int ConfigIDs = ActorLinker_ConfigId(myActor);


        // ===================== AIM TARGET & DRAW =====================
         if(AimSkill)
        { 
                    EnemyTarget.myPos = myPos;
                    
                    
                    //void* ObjLinker = *(void**)((uintptr_t)enemyLinker + GetFieldOffset(oxorany("Project_d.dll"),oxorany("Kyrios.Actor"),oxorany("ActorLinker"),oxorany("ObjLinker")));
                    //if (!ObjLinker) return; // dừng

                    //EnemyTarget.ConfigID = *(int*)((uintptr_t)ObjLinker + GetFieldOffset(oxorany("Project_d.dll"),oxorany("Assets.Scripts.GameLogic"),oxorany("ActorConfig"),oxorany("ConfigID"))); 
                    //if (!EnemyTarget.ConfigID) return; // dừng


                    // ==== Gán dữ liệu theo ConfigID ====
                 if (ConfigIDs == 196) { EnemyTarget.Ranger = Rangeskill2; EnemyTarget.bullettime = 0.43f; tagid2 = 2; }
                 if (ConfigIDs == 157) { EnemyTarget.Ranger = Rangeskill2; EnemyTarget.bullettime = 0.8f;  tagid2 = 2; }
                 if (ConfigIDs == 175) { EnemyTarget.Ranger = Rangeskill2; EnemyTarget.bullettime = 0.7f;  tagid2 = 2; }
                 if (ConfigIDs == 108) { EnemyTarget.Ranger = Rangeskill2; EnemyTarget.bullettime = 0.85f; tagid2 = 2; }
                 if (ConfigIDs == 174) { EnemyTarget.Ranger = Rangeskill1; EnemyTarget.bullettime = 0.99f; tagid1 = 1; }
                 if (ConfigIDs == 521) { EnemyTarget.Ranger = Rangeskill1; EnemyTarget.bullettime = 0.5f;  tagid1 = 1; }
                 if (ConfigIDs == 195) { EnemyTarget.Ranger = Rangeskill2; EnemyTarget.bullettime = 0.3f;  tagid2 = 2; }
                 if (ConfigIDs == 529) { EnemyTarget.Ranger = Rangeskill2; EnemyTarget.bullettime = 0.85f; tagid2 = 2; }
                 if (ConfigIDs == 545) { EnemyTarget.Ranger = Rangeskill2; EnemyTarget.bullettime = 0.7f;  tagid2 = 2; }
                 if (ConfigIDs == 152) { EnemyTarget.Ranger = Rangeskill2; EnemyTarget.bullettime = 1.1f;  tagid2 = 2; }


                   // if (distanceToMe <= EnemyTarget.Ranger && skillSlot == tagid)
                    if (distanceToMe <= EnemyTarget.Ranger && (skillSlot == tagid1 || skillSlot == tagid2 || skillSlot == tagid3))
                    {
                        if (aimType == 0 && EnemyHp < lowestHp)
                        {
                            Entity = EnemyRoot;
                            EnemyTarget.enemyPos = VIntVector(NowLocation);
                            EnemyTarget.moveForward = VIntVector(forwardEnemy);
                            EnemyTarget.currentSpeed = speedEnemy;
                            lowestHp = EnemyHp;
                        }
                        if (aimType == 1)
                        {
                            if (EpPercent < lowestHpPercent)
                            {
                                Entity = EnemyRoot;
                                EnemyTarget.enemyPos = VIntVector(NowLocation);
                                EnemyTarget.moveForward = VIntVector(forwardEnemy);
                                EnemyTarget.currentSpeed = speedEnemy;
                                lowestHpPercent = EpPercent;
                            }
                        
                            if (EpPercent == lowestHpPercent && EnemyHp < lowestHp2)
                            {
                                EnemyTarget.enemyPos = VIntVector(NowLocation);
                                EnemyTarget.moveForward = VIntVector(forwardEnemy);
                                EnemyTarget.currentSpeed = speedEnemy;
                                lowestHp2 = EnemyHp;
                                lowestHpPercent = EpPercent;
                            }
                        }
                        
                        if (aimType == 2 && distanceToMe < closestEnemyDistance)
                        {
                            Entity = EnemyRoot;
                            EnemyTarget.enemyPos = VIntVector(NowLocation);
                            EnemyTarget.moveForward = VIntVector(forwardEnemy);
                            EnemyTarget.currentSpeed = speedEnemy;
                            closestEnemyDistance = distanceToMe;
                        }
                    
                        if (aimType == 3 && distancess < closestEnemyDistanceView && IsCharging)
                        {
                            Entity = EnemyRoot;
                            EnemyTarget.enemyPos = VIntVector(NowLocation);
                            EnemyTarget.moveForward = VIntVector(forwardEnemy);
                            EnemyTarget.currentSpeed = speedEnemy;
                            closestEnemyDistanceView = distancess;
                      }
                 }
            }
    //============= end Aimskill =========
       
       
        // ================== FOG CHECK ==================
        if (ESPEnable)
        {

        if(CheckFogEsp) // Nếu địch không hiển thị trên map
        {	
            if(isVisible){ continue; }
        }
       
          // ================== Esp Line ==================
       if (EspLine)
{
    
    draw->AddLine(
                myScreenPos,
                ImVec2(rootPos_Vec2.x, rootPos_Vec2.y + 7.0f),
                IM_COL32(255, 0, 0, 200),
                0.5f
            );
  
}

float boxHeight = 50.0f;
float boxWidth  = boxHeight * 0.45f;
float boxYOffset = 8.0f; // chỉnh 6–10 là đẹp

// ⚠️ KHAI BÁO NGOÀI IF
ImVec2 boxMin(
    rootPos_Vec2.x - boxWidth / 2.0f,
    rootPos_Vec2.y - boxHeight
);

ImVec2 boxMax(
    rootPos_Vec2.x + boxWidth / 2.0f,
    rootPos_Vec2.y
);

// chỉ IF phần vẽ
if (ESPBox)
{
    draw->AddRect(
        boxMin,
        boxMax,
        IM_COL32(255, 0, 0, 220),
        0.0f,
        0,
        1.2f
    );
}


// ================== DISTANCE TEXT ==================
if(PlayerDistance)
{
char distText[32];
snprintf(distText, sizeof(distText), "%.1fm", distanceToMe);

ImVec2 textSize = ImGui::CalcTextSize(distText);

ImVec2 textPos = ImVec2(
    rootPos_Vec2.x - textSize.x / 2.0f,
    boxMax.y + 2.0f
);

// Shadow
draw->AddText(
    ImVec2(textPos.x + 1, textPos.y + 1),
    IM_COL32(0, 0, 0, 180),
    distText
);

// Text
draw->AddText(
    textPos,
    IM_COL32(255, 255, 255, 255),
    distText
);
}
        // ================== HEALTH ==================
        if (ESP_HP && EnemyHpTotal > 0)
        {

            float boxHeight = 50.0f;
            float boxWidth  = boxHeight * 0.45f;
            float HpPercent = ImClamp((float)EnemyHp / (float)EnemyHpTotal, 0.0f, 1.0f);

            ImVec2 hpBarMin(boxMin.x - 6.0f, boxMin.y);
            ImVec2 hpBarMax(hpBarMin.x + 4.0f, boxMax.y);

            draw->AddRectFilled(hpBarMin, hpBarMax, IM_COL32(0, 0, 0, 160));

            ImVec2 hpFillMin(
                hpBarMin.x,
                hpBarMax.y - boxHeight * HpPercent
            );

            ImU32 hpColor =
                HpPercent > 0.6f ? IM_COL32(0,255,0,220) :
                HpPercent > 0.3f ? IM_COL32(255,200,0,220) :
                                   IM_COL32(255,0,0,220);

            draw->AddRectFilled(hpFillMin, hpBarMax, hpColor);
           }
        }
    }

if (AimSkill && Entity != NULL)
{
    if (EnemyTarget.myPos != Vector3::zero() &&
        EnemyTarget.enemyPos != Vector3::zero())
    {
        Vector3 toEnemy = EnemyTarget.enemyPos - EnemyTarget.myPos;
        float distanceToEnemy = Vector3::Magnitude(toEnemy);

        float bulletSpeed = EnemyTarget.Ranger / EnemyTarget.bullettime;
        float timeToHit = distanceToEnemy / bulletSpeed;

        Vector3 futureEnemyPos =
            EnemyTarget.enemyPos +
            EnemyTarget.moveForward * EnemyTarget.currentSpeed * timeToHit;

        // ================= DRAW =================
        Vector3 EnemySC = Camera::get_main()->WorldToScreen(futureEnemyPos);

        if (EnemySC.z > 0)
        {
            ImVec2 startLine(kWidth / 2, kHeight / 2);
            ImVec2 endLine(EnemySC.x * kWidth, kHeight - EnemySC.y * kHeight);

            if (drawType == 0)
            {
          
            }
            else if (drawType == 1)
            {
                if (skillSlot == tagid1 || skillSlot == tagid2 || skillSlot == tagid3)
                {
                    draw->AddLine(startLine, endLine, ImColor(0,255,0,90), 1.5f);
                    draw->AddCircle(endLine, 4.f, IM_COL32(0,255,0,100), 0, 1.5f);
                    draw->AddCircleFilled(endLine, 2.8f, IM_COL32(0,255,0,200));
                }
            }
            // ----- 2: Khi Xem -----
            else if (drawType == 2)
            {
                if (IsCharging && (skillSlot == tagid1 || skillSlot == tagid2 || skillSlot == tagid3))
                {
                    draw->AddLine(startLine, endLine, ImColor(0,255,0,90), 1.5f);
                    draw->AddCircle(endLine, 4.f, IM_COL32(0,255,0,100), 0, 1.5f);
                    draw->AddCircleFilled(endLine, 2.8f, IM_COL32(0,255,0,200));
                }
            }
        }
    }
}
else
{
       EnemyTarget.enemyPos = Vector3::zero();
       EnemyTarget.moveForward = Vector3::zero();
   }
}

static NSString* GetiPhoneModelName(NSString *machine)
{
    static NSDictionary *map;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        map = @{
            // ================= iPhone =================
            // Original → 5s
            @"iPhone1,1": @"iPhone",
            @"iPhone1,2": @"iPhone 3G",
            @"iPhone2,1": @"iPhone 3GS",
            @"iPhone3,1": @"iPhone 4",
            @"iPhone3,2": @"iPhone 4",
            @"iPhone3,3": @"iPhone 4",
            @"iPhone4,1": @"iPhone 4s",
            @"iPhone5,1": @"iPhone 5",
            @"iPhone5,2": @"iPhone 5",
            @"iPhone5,3": @"iPhone 5c",
            @"iPhone5,4": @"iPhone 5c",
            @"iPhone6,1": @"iPhone 5s",
            @"iPhone6,2": @"iPhone 5s",

            // 6 / 6s / SE
            @"iPhone7,2": @"iPhone 6",
            @"iPhone7,1": @"iPhone 6 Plus",
            @"iPhone8,1": @"iPhone 6s",
            @"iPhone8,2": @"iPhone 6s Plus",
            @"iPhone8,4": @"iPhone SE (1st gen)",

            // 7 / 8 / X
            @"iPhone9,1": @"iPhone 7",
            @"iPhone9,3": @"iPhone 7",
            @"iPhone9,2": @"iPhone 7 Plus",
            @"iPhone9,4": @"iPhone 7 Plus",
            @"iPhone10,1": @"iPhone 8",
            @"iPhone10,4": @"iPhone 8",
            @"iPhone10,2": @"iPhone 8 Plus",
            @"iPhone10,5": @"iPhone 8 Plus",
            @"iPhone10,3": @"iPhone X",
            @"iPhone10,6": @"iPhone X",

            // XS / XR / 11
            @"iPhone11,2": @"iPhone XS",
            @"iPhone11,4": @"iPhone XS Max",
            @"iPhone11,6": @"iPhone XS Max",
            @"iPhone11,8": @"iPhone XR",
            @"iPhone12,1": @"iPhone 11",
            @"iPhone12,3": @"iPhone 11 Pro",
            @"iPhone12,5": @"iPhone 11 Pro Max",
            @"iPhone12,8": @"iPhone SE (2nd gen)",

            // 12
            @"iPhone13,1": @"iPhone 12 mini",
            @"iPhone13,2": @"iPhone 12",
            @"iPhone13,3": @"iPhone 12 Pro",
            @"iPhone13,4": @"iPhone 12 Pro Max",

            // 13
            @"iPhone14,4": @"iPhone 13 mini",
            @"iPhone14,5": @"iPhone 13",
            @"iPhone14,2": @"iPhone 13 Pro",
            @"iPhone14,3": @"iPhone 13 Pro Max",
            @"iPhone14,6": @"iPhone SE (3rd gen)",

            // 14
            @"iPhone14,7": @"iPhone 14",
            @"iPhone14,8": @"iPhone 14 Plus",
            @"iPhone15,2": @"iPhone 14 Pro",
            @"iPhone15,3": @"iPhone 14 Pro Max",

            // 15
            @"iPhone15,4": @"iPhone 15",
            @"iPhone15,5": @"iPhone 15 Plus",
            @"iPhone16,1": @"iPhone 15 Pro",
            @"iPhone16,2": @"iPhone 15 Pro Max",

            // 16
            @"iPhone17,1": @"iPhone 16",
            @"iPhone17,2": @"iPhone 16 Plus",
            @"iPhone17,3": @"iPhone 16 Pro",
            @"iPhone17,4": @"iPhone 16 Pro Max",

            // ================= iPad =================
            @"iPad1,1": @"iPad",
            @"iPad2,1": @"iPad 2",
            @"iPad2,2": @"iPad 2",
            @"iPad2,3": @"iPad 2",
            @"iPad2,4": @"iPad 2",

            @"iPad3,1": @"iPad (3rd gen)",
            @"iPad3,2": @"iPad (3rd gen)",
            @"iPad3,3": @"iPad (3rd gen)",
            @"iPad3,4": @"iPad (4th gen)",
            @"iPad3,5": @"iPad (4th gen)",
            @"iPad3,6": @"iPad (4th gen)",

            // iPad Air
            @"iPad4,1": @"iPad Air",
            @"iPad4,2": @"iPad Air",
            @"iPad5,3": @"iPad Air 2",
            @"iPad5,4": @"iPad Air 2",
            @"iPad11,3": @"iPad Air (3rd gen)",
            @"iPad13,1": @"iPad Air (4th gen)",
            @"iPad13,16": @"iPad Air (5th gen)",

            // iPad mini
            @"iPad2,5": @"iPad mini",
            @"iPad2,6": @"iPad mini",
            @"iPad2,7": @"iPad mini",
            @"iPad4,4": @"iPad mini 2",
            @"iPad4,5": @"iPad mini 2",
            @"iPad4,6": @"iPad mini 2",
            @"iPad4,7": @"iPad mini 3",
            @"iPad4,8": @"iPad mini 3",
            @"iPad4,9": @"iPad mini 3",
            @"iPad5,1": @"iPad mini 4",
            @"iPad5,2": @"iPad mini 4",
            @"iPad11,1": @"iPad mini (5th gen)",
            @"iPad14,1": @"iPad mini (6th gen)",

            // iPad Pro
            @"iPad6,3": @"iPad Pro 9.7\"",
            @"iPad6,4": @"iPad Pro 9.7\"",
            @"iPad6,7": @"iPad Pro 12.9\"",
            @"iPad6,8": @"iPad Pro 12.9\"",
            @"iPad7,1": @"iPad Pro 12.9\" (2nd gen)",
            @"iPad7,2": @"iPad Pro 12.9\" (2nd gen)",
            @"iPad7,3": @"iPad Pro 10.5\"",
            @"iPad7,4": @"iPad Pro 10.5\"",
            @"iPad8,1": @"iPad Pro 11\"",
            @"iPad8,5": @"iPad Pro 12.9\" (3rd gen)",
            @"iPad8,9": @"iPad Pro 11\" (2nd gen)",
            @"iPad8,11": @"iPad Pro 12.9\" (4th gen)",
            @"iPad13,4": @"iPad Pro 11\" (3rd gen)",
            @"iPad13,8": @"iPad Pro 12.9\" (5th gen)",

            // ================= iPod =================
            @"iPod1,1": @"iPod touch",
            @"iPod2,1": @"iPod touch (2nd gen)",
            @"iPod3,1": @"iPod touch (3rd gen)",
            @"iPod4,1": @"iPod touch (4th gen)",
            @"iPod5,1": @"iPod touch (5th gen)",
            @"iPod7,1": @"iPod touch (6th gen)",
            @"iPod9,1": @"iPod touch (7th gen)",

            // ================= Apple TV =================
            @"AppleTV2,1": @"Apple TV (2nd gen)",
            @"AppleTV3,1": @"Apple TV (3rd gen)",
            @"AppleTV5,3": @"Apple TV HD",
            @"AppleTV6,2": @"Apple TV 4K",
            @"AppleTV11,1": @"Apple TV 4K (2nd gen)",

            // ================= Simulator =================
            @"i386": @"Simulator",
            @"x86_64": @"Simulator",
            @"arm64": @"Simulator (Apple Silicon)"
        };
    });

    return map[machine] ?: machine; // fallback an toàn
}
@end
