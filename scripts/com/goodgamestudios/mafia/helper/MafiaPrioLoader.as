package com.goodgamestudios.mafia.helper
{
   import com.goodgamestudios.mafia.MafiaEnvironmentGlobals;
   import com.goodgamestudios.mafia.constants.Constants_Background;
   import flash.events.Event;
   
   public class MafiaPrioLoader
   {
      
      private static var _instance:MafiaPrioLoader;
       
      
      private var backgroundsToLoad:Vector.<String>;
      
      private var avatarPartsToLoad:Vector.<String>;
      
      private var familyCrestPartsToLoad:Vector.<String>;
      
      private var _backgroundNumbers:Array;
      
      public function MafiaPrioLoader()
      {
         this.backgroundsToLoad = new Vector.<String>();
         this.avatarPartsToLoad = new Vector.<String>();
         this.familyCrestPartsToLoad = new Vector.<String>();
         super();
      }
      
      public static function get instance() : MafiaPrioLoader
      {
         if(MafiaPrioLoader._instance == null)
         {
            MafiaPrioLoader._instance = new MafiaPrioLoader();
         }
         return MafiaPrioLoader._instance;
      }
      
      public function startBackgroundLoading(param1:int) : void
      {
         this._backgroundNumbers = [param1 + "_" + Constants_Background.BG_HOME,param1 + "_" + Constants_Background.BG_PROFILE,param1 + "_" + Constants_Background.BG_MISSION,param1 + "_" + Constants_Background.BG_WEAPONS,param1 + "_" + Constants_Background.BG_KIOSK,param1 + "_" + Constants_Background.BG_FIGHT,param1 + "_" + Constants_Background.BG_RANKING,param1 + "_" + Constants_Background.BG_BOOSTER,param1 + "_" + Constants_Background.BG_CUSTOMIZE,param1 + "_" + Constants_Background.BG_MULTIFIGHT,param1 + "_" + Constants_Background.BG_MAIL];
         this.createBackgroundList();
         this.updateBackgroundLoading();
      }
      
      public function startAvatarPartAndFamilyPartLoading() : void
      {
         this.startAvatarPartLoading();
      }
      
      private function startAvatarPartLoading() : void
      {
         this.createAvatarPartList();
         this.updateAvatarPartLoading();
      }
      
      private function startFamilyCrestPartLoading() : void
      {
         this.createFamilyCrestPartList();
         this.updateFamilyCrestPartLoading();
      }
      
      private function createAvatarPartList() : void
      {
         this.avatarPartsToLoad = AvatarHelper.getCompleteAssetStringList();
      }
      
      private function createFamilyCrestPartList() : void
      {
         this.familyCrestPartsToLoad = FamilyCrestHelper.getCompleteAssetStringList();
      }
      
      private function updateBackgroundLoading() : void
      {
         if(this.backgroundsToLoad.length == 0)
         {
            return;
         }
         var _loc1_:String = this.backgroundsToLoad.shift();
         if(SWFLoaderHelper.instance.isSWFLoaded(_loc1_) || SWFLoaderHelper.instance.isSWFLoading(_loc1_))
         {
            this.updateBackgroundLoading();
         }
         else
         {
            SWFLoaderHelper.instance.loadSWF(_loc1_,this.completeBackgroundLoadingStep,this.completeBackgroundLoadingStep);
         }
      }
      
      private function updateAvatarPartLoading() : void
      {
         if(this.avatarPartsToLoad.length == 0)
         {
            this.startFamilyCrestPartLoading();
            return;
         }
         var _loc1_:String = this.avatarPartsToLoad.shift();
         if(SWFLoaderHelper.instance.isSWFLoaded(_loc1_) || SWFLoaderHelper.instance.isSWFLoading(_loc1_))
         {
            this.updateAvatarPartLoading();
         }
         else
         {
            SWFLoaderHelper.instance.loadSWF(_loc1_,this.completeAvatarPartLoadingStep,this.completeAvatarPartLoadingStep);
         }
      }
      
      private function updateFamilyCrestPartLoading() : void
      {
         if(this.familyCrestPartsToLoad.length == 0)
         {
            return;
         }
         var _loc1_:String = this.familyCrestPartsToLoad.shift();
         if(SWFLoaderHelper.instance.isSWFLoaded(_loc1_) || SWFLoaderHelper.instance.isSWFLoading(_loc1_))
         {
            this.updateFamilyCrestPartLoading();
         }
         else
         {
            SWFLoaderHelper.instance.loadSWF(_loc1_,this.completeFamilyCrestLoadingStep,this.completeFamilyCrestLoadingStep);
         }
      }
      
      private function completeBackgroundLoadingStep(param1:Event) : void
      {
         this.updateBackgroundLoading();
      }
      
      private function completeAvatarPartLoadingStep(param1:Event) : void
      {
         this.updateAvatarPartLoading();
      }
      
      private function completeFamilyCrestLoadingStep(param1:Event) : void
      {
         this.updateFamilyCrestPartLoading();
      }
      
      private function createBackgroundList() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this._backgroundNumbers.length)
         {
            this.backgroundsToLoad.push(this.getScreenBackgroundSwfUrl(this._backgroundNumbers[_loc1_]));
            _loc1_++;
         }
      }
      
      protected final function getScreenBackgroundSwfUrl(param1:String) : String
      {
         return this.env.baseURL + "/backgrounds/ScreenBackground_" + param1 + ".swf";
      }
      
      private function get env() : MafiaEnvironmentGlobals
      {
         return new MafiaEnvironmentGlobals();
      }
   }
}
