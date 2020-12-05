package com.goodgamestudios.basic.model.components
{
   import com.goodgamestudios.basic.EnvGlobalsHandler;
   import com.goodgamestudios.basic.IEnvironmentGlobals;
   import com.goodgamestudios.basic.constants.BasicConstants;
   import com.goodgamestudios.textfield.RuntimeLoadedFontConfigVO;
   
   public class BasicFontData
   {
       
      
      protected var _runtimeLoadedFontsConfigurations:Vector.<RuntimeLoadedFontConfigVO>;
      
      public function BasicFontData()
      {
         super();
         this.initialize();
      }
      
      private function initialize() : void
      {
         this.initializeRuntimeLoadedFontConfigurations();
      }
      
      protected function initializeRuntimeLoadedFontConfigurations() : void
      {
         this._runtimeLoadedFontsConfigurations = new Vector.<RuntimeLoadedFontConfigVO>();
         var _loc1_:RuntimeLoadedFontConfigVO = new RuntimeLoadedFontConfigVO(BasicConstants.LANGUAGE_KOREAN);
         _loc1_.fontName = this.getFontNameByGGSLanguageCode(_loc1_.ggsLanguageCode);
         var _loc2_:RuntimeLoadedFontConfigVO = new RuntimeLoadedFontConfigVO(BasicConstants.LANGUAGE_JAPANESE);
         _loc2_.fontName = this.getFontNameByGGSLanguageCode(_loc2_.ggsLanguageCode);
         var _loc3_:RuntimeLoadedFontConfigVO = new RuntimeLoadedFontConfigVO(BasicConstants.LANGUAGE_CHINESE_SIMPLE);
         _loc3_.fontName = this.getFontNameByGGSLanguageCode(_loc3_.ggsLanguageCode);
         var _loc4_:RuntimeLoadedFontConfigVO = new RuntimeLoadedFontConfigVO(BasicConstants.LANGUAGE_CHINESE_TRADITIONAL);
         _loc4_.fontName = this.getFontNameByGGSLanguageCode(_loc4_.ggsLanguageCode);
         var _loc5_:RuntimeLoadedFontConfigVO = new RuntimeLoadedFontConfigVO(BasicConstants.LANGUAGE_RUSSIAN);
         _loc5_.fontName = this.getFontNameByGGSLanguageCode(_loc5_.ggsLanguageCode);
         var _loc6_:RuntimeLoadedFontConfigVO = new RuntimeLoadedFontConfigVO(BasicConstants.LANGUAGE_ARABIC);
         _loc6_.fontName = this.getFontNameByGGSLanguageCode(_loc6_.ggsLanguageCode);
         var _loc7_:RuntimeLoadedFontConfigVO = new RuntimeLoadedFontConfigVO(BasicConstants.LANGUAGE_GREECE);
         _loc7_.fontName = this.getFontNameByGGSLanguageCode(_loc7_.ggsLanguageCode);
         var _loc8_:RuntimeLoadedFontConfigVO = new RuntimeLoadedFontConfigVO(BasicConstants.LANGUAGE_BULGARIAN);
         _loc8_.fontName = this.getFontNameByGGSLanguageCode(_loc8_.ggsLanguageCode);
         this._runtimeLoadedFontsConfigurations.push(_loc1_);
         this._runtimeLoadedFontsConfigurations.push(_loc2_);
         this._runtimeLoadedFontsConfigurations.push(_loc3_);
         this._runtimeLoadedFontsConfigurations.push(_loc4_);
         this._runtimeLoadedFontsConfigurations.push(_loc5_);
         this._runtimeLoadedFontsConfigurations.push(_loc6_);
         this._runtimeLoadedFontsConfigurations.push(_loc7_);
         this._runtimeLoadedFontsConfigurations.push(_loc8_);
      }
      
      public final function get runtimeLoadedFontsConfigurations() : Vector.<RuntimeLoadedFontConfigVO>
      {
         return this._runtimeLoadedFontsConfigurations;
      }
      
      public final function getFontNameByGGSLanguageCode(param1:String) : String
      {
         return this.env.gameTitle + "Font1_" + param1;
      }
      
      public final function currentLanguageRequiresRuntimeLoadedFont(param1:String) : Boolean
      {
         return this.isRuntimeLoadedFont(this.getFontNameByGGSLanguageCode(param1));
      }
      
      public final function isRuntimeLoadedFont(param1:String = "") : Boolean
      {
         var _loc2_:RuntimeLoadedFontConfigVO = null;
         for each(_loc2_ in this._runtimeLoadedFontsConfigurations)
         {
            if(param1 == _loc2_.fontName)
            {
               return true;
            }
         }
         return false;
      }
      
      private function get env() : IEnvironmentGlobals
      {
         return EnvGlobalsHandler.globals;
      }
   }
}
