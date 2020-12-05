package com.goodgamestudios.basic.view.dialogs
{
   import com.goodgamestudios.basic.model.BasicModel;
   import com.goodgamestudios.basic.view.BasicProperties;
   
   public class BasicStandardOkDialogProperties extends BasicProperties
   {
       
      
      public var buttonLabel_ok:String = "Okay";
      
      public var title:String = "";
      
      public var copy:String = "";
      
      public var functionOk:Function;
      
      public function BasicStandardOkDialogProperties(param1:String, param2:String, param3:Function = null, param4:String = "")
      {
         this.functionOk = param3;
         if(param4.length > 0)
         {
            this.buttonLabel_ok = param4;
         }
         else
         {
            this.buttonLabel_ok = this.delegateText("generic_btn_okay");
         }
         this.title = param1;
         this.copy = param2;
         super();
      }
      
      protected function delegateText(param1:String) : String
      {
         return BasicModel.languageData.getTextById(param1);
      }
   }
}
