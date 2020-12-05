package com.goodgamestudios.basic.controller.clientCommands
{
   import com.goodgamestudios.basic.EnvGlobalsHandler;
   import com.goodgamestudios.basic.IEnvironmentGlobals;
   import com.goodgamestudios.basic.event.LanguageDataEvent;
   import com.goodgamestudios.basic.model.BasicModel;
   import com.goodgamestudios.basic.view.BasicLanguageFontManager;
   import com.goodgamestudios.commanding.SimpleCommand;
   import com.goodgamestudios.textfield.manager.GoodgameTextFieldManager;
   
   public class BasicChangeLanguageCommand extends SimpleCommand
   {
      
      public static const NAME:String = "BasicChangeLanguageCommand";
       
      
      public function BasicChangeLanguageCommand()
      {
         super();
      }
      
      override public function execute(param1:Object = null) : void
      {
         if(BasicModel.languageData.hasEventListener(LanguageDataEvent.XML_LOAD_COMPLETE))
         {
            BasicModel.languageData.removeEventListener(LanguageDataEvent.XML_LOAD_COMPLETE,this.onLanguageXMLComplete);
         }
         BasicModel.languageData.addEventListener(LanguageDataEvent.XML_LOAD_COMPLETE,this.onLanguageXMLComplete);
         BasicModel.languageData.loadLanguage();
      }
      
      private function onLanguageXMLComplete(param1:LanguageDataEvent) : void
      {
         BasicModel.languageData.removeEventListener(LanguageDataEvent.XML_LOAD_COMPLETE,this.onLanguageXMLComplete);
         var _loc2_:BasicLanguageFontManager = BasicLanguageFontManager.getInstance();
         if(_loc2_.useDefaultFont && !this.env.useLegacyFontManagement)
         {
            GoodgameTextFieldManager.getInstance().updateTextInAllTextFields();
            return;
         }
         _loc2_.addEventListener(LanguageDataEvent.FONT_LOAD_COMPLETE,this.onFontLoadComplete);
         _loc2_.initFontSwf();
      }
      
      private function onFontLoadComplete(param1:LanguageDataEvent) : void
      {
         var _loc2_:BasicLanguageFontManager = BasicLanguageFontManager.getInstance();
         _loc2_.removeEventListener(LanguageDataEvent.FONT_LOAD_COMPLETE,this.onFontLoadComplete);
         if(this.env.useLegacyFontManagement)
         {
            return;
         }
         GoodgameTextFieldManager.getInstance().updateTextInAllTextFields();
      }
      
      private function get env() : IEnvironmentGlobals
      {
         return EnvGlobalsHandler.globals;
      }
   }
}
