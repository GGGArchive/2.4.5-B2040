package com.goodgamestudios.mafia.constants
{
   import com.goodgamestudios.mafia.constants.enums.ItemQuality;
   import com.goodgamestudios.mafia.constants.enums.ItemType;
   import com.goodgamestudios.mafia.constants.enums.WeaponType;
   import com.goodgamestudios.mafia.controller.MafiaSoundController;
   import com.goodgamestudios.mafia.vo.fight.FightItemVO;
   import flash.media.Sound;
   
   public class Constants_Weapon
   {
      
      public static const FRAMELABEL_SOUND:String = "sound";
      
      public static const FRAMELABEL_SECONDSOUND:String = "sound2";
      
      public static const FRAMELABEL_END:String = "end";
      
      public static const FRAMELABEL_DRAW_WEAPON_SOUND:String = "startsound";
      
      public static const ANI_SINGLESHOT_ID:String = "SingleshotAnimation";
      
      public static const ANI_KNUCKLEDUSTER_ID:String = "KnuckledusterAnimation";
      
      public static const ANI_MULTISHOT_ID:String = "MultishotAnimation";
      
      public static const ANI_PUMPGUN_ID:String = "PumpgunAnimation";
      
      public static const ANI_DYNAMITE_NORMAL:String = "DynamiteAnimation";
      
      public static const ANI_DYNAMITE_PREMIUM:String = "TNTAnimation";
      
      public static const ANI_SMOKE_GRENADE:String = "SmokeGrenadeAnimation";
      
      public static const ANI_STUN_GRENADE:String = "StunGrenadeAnimation";
      
      public static const ANI_THROWING_KNIFE:String = "ThrowingKnifeAnimation";
      
      public static const ANI_KNIFEOLD_ID:int = 1;
      
      public static const ANI_BASEBALLBAT_ID:int = 2;
      
      public static const ANI_AXE_ID:int = 3;
      
      public static const ANI_KNIFE_ID:int = 4;
      
      public static const ANI_TRAILWEAPON_ID:int = 5;
      
      public static const ANI_MACHETE_ID:int = 6;
      
      public static const ANI_BRRRRRR_ID:int = 8;
      
      public static const ANI_ROCKET_ID:String = "RocketAnimation";
      
      public static const ANI_LEGENDARYHAMMER:int = 13;
      
      public static const LEGENDARY_HAMMER_ID:int = 27;
      
      public static const MAX_WEAPON_ID:int = 43;
      
      public static const CONSUME_DYNAMITE:int = 10;
      
      public static const CONSUME_LEGENDARY_DYNAMITE:int = 20;
      
      public static const CONSUME_SMOKE_GRENADE:int = 13;
      
      public static const CONSUME_STUN_GRENADE:int = 12;
      
      public static const CONSUME_THROWING_KNIFE:int = 11;
      
      public static const CONSUME_ADRENALINE:int = 19;
       
      
      public function Constants_Weapon()
      {
         super();
      }
      
      public static function getItemAnimation(param1:FightItemVO) : String
      {
         switch(param1.type)
         {
            case ItemType.Weapon:
               return getWeaponAnimation(param1.subtype as WeaponType);
            case ItemType.Consumable:
               return getConsumeAnimation(param1);
            default:
               trace("invalid item type: no animation available");
               return null;
         }
      }
      
      private static function getConsumeAnimation(param1:FightItemVO) : String
      {
         switch(param1.id)
         {
            case CONSUME_DYNAMITE:
            case CONSUME_LEGENDARY_DYNAMITE:
               return getDynamiteAnimation(param1.quality);
            case CONSUME_SMOKE_GRENADE:
               return ANI_SMOKE_GRENADE;
            case CONSUME_STUN_GRENADE:
               return ANI_STUN_GRENADE;
            case CONSUME_THROWING_KNIFE:
               return ANI_THROWING_KNIFE;
            default:
               trace("invalid item id: no animation available");
               return null;
         }
      }
      
      private static function getDynamiteAnimation(param1:ItemQuality) : String
      {
         switch(param1)
         {
            case ItemQuality.Normal:
               return ANI_DYNAMITE_NORMAL;
            case ItemQuality.Premium:
            case ItemQuality.Epic:
            case ItemQuality.Legendary:
               return ANI_DYNAMITE_PREMIUM;
            default:
               return ANI_DYNAMITE_NORMAL;
         }
      }
      
      private static function getWeaponAnimation(param1:WeaponType) : String
      {
         switch(param1)
         {
            case WeaponType.Pistol:
               return ANI_SINGLESHOT_ID;
            case WeaponType.Smg:
               return ANI_MULTISHOT_ID;
            case WeaponType.Shotgun:
               return ANI_PUMPGUN_ID;
            case WeaponType.Assault:
               return ANI_MULTISHOT_ID;
            case WeaponType.Sniper:
               return ANI_SINGLESHOT_ID;
            default:
               return ANI_KNUCKLEDUSTER_ID;
         }
      }
      
      public static function getWeaponSound(param1:String, param2:String) : Sound
      {
         switch(param2)
         {
            case FRAMELABEL_DRAW_WEAPON_SOUND:
               return MafiaSoundController.SND_SHOW_WEAPON;
            case FRAMELABEL_SOUND:
               switch(param1)
               {
                  case ANI_KNIFEOLD_ID:
                  case ANI_KNIFE_ID:
                  case ANI_MACHETE_ID:
                     return MafiaSoundController.SND_KNIFE;
                  case ANI_BASEBALLBAT_ID:
                  case ANI_AXE_ID:
                  case ANI_TRAILWEAPON_ID:
                  case ANI_BRRRRRR_ID:
                  case ANI_KNUCKLEDUSTER_ID:
                  case ANI_LEGENDARYHAMMER:
                     return MafiaSoundController.SND_IMPACT;
                  case ANI_SINGLESHOT_ID:
                  case ANI_PUMPGUN_ID:
                     return MafiaSoundController.SND_SHOT;
                  case ANI_MULTISHOT_ID:
                     return MafiaSoundController.SND_THOMPSON;
                  case ANI_ROCKET_ID:
                     return MafiaSoundController.SND_EXPLOSION;
                  case ANI_DYNAMITE_NORMAL:
                  case ANI_DYNAMITE_PREMIUM:
                     return MafiaSoundController.SND_DYNAMITE;
                  default:
                     trace("Error: encountered unknown animation id while loading sound");
                     return null;
               }
            case FRAMELABEL_SECONDSOUND:
               switch(param1)
               {
                  case ANI_SINGLESHOT_ID:
                     return MafiaSoundController.SND_HIT;
                  default:
                     trace("Error: encountered unknown animation id while loading sound");
                     return null;
               }
            default:
               trace("Error: unknown sound frame label");
               return null;
         }
      }
   }
}
