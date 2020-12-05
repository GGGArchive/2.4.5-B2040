package com.goodgamestudios.language.fontManager
{
   import com.goodgamestudios.textfield.FontConfigVO;
   
   public interface ILanguageFontManager
   {
       
      
      function currentLanguageRequiresRuntimeLoadedFont(param1:String) : Boolean;
      
      function isRuntimeLoadedFont(param1:String = "") : Boolean;
      
      function getFontNameByGGSLanguageCode(param1:String) : String;
      
      function get useDefaultFont() : Boolean;
      
      function isFontAbleToDisplayGlyphs(param1:String, param2:String) : Boolean;
      
      function getFontConfigVOByFontName(param1:String) : FontConfigVO;
   }
}
