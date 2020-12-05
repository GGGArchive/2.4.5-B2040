package com.goodgamestudios.mafia.controller
{
   import com.goodgamestudios.basic.controller.BasicSoundController;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import flash.media.Sound;
   
   public class MafiaSoundController extends BasicSoundController
   {
      
      public static var SND_BUTTON:Sound = new snd_button();
      
      public static var SND_LEVEL_UP:Sound = new snd_levelup();
      
      public static var SND_ACHIEVEMENT:Sound = new snd_achievement();
      
      public static var SND_SOLD:Sound = new snd_sold();
      
      public static var SND_WIN_FIGHT:Sound = new snd_winfight();
      
      public static var SND_LOSE_FIGHT:Sound = new snd_losefight();
      
      public static var SND_SHOW_WEAPON:Sound = new snd_showweapon();
      
      public static var SND_IMPACT:Sound = new snd_impact();
      
      public static var SND_FLIGHT:Sound = new snd_flight();
      
      public static var SND_CRIT:Sound = new snd_crit();
      
      public static var SND_KNIFE:Sound = new snd_knife();
      
      public static var SND_SHOT:Sound = new snd_rifle();
      
      public static var SND_EXPLOSION:Sound = new snd_explosion();
      
      public static var SND_DYNAMITE:Sound = new snd_dynamite();
      
      public static var SND_THOMPSON:Sound = new snd_thompson();
      
      public static var SND_HIT:Sound = new snd_hit();
       
      
      public function MafiaSoundController()
      {
         var _loc2_:Boolean = false;
         var _loc3_:Boolean = false;
         super();
         var _loc1_:Array = MafiaModel.localData.readSoundSettings();
         if(_loc1_)
         {
            _loc2_ = _loc1_[0];
            _loc3_ = _loc1_[2];
            if(_loc2_)
            {
               muteMusic();
            }
            if(_loc3_)
            {
               muteEffects();
            }
         }
      }
   }
}
