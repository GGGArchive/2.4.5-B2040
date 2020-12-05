package com.goodgamestudios.basic.view.dialogs
{
   import com.goodgamestudios.basic.constants.GenericTextIds;
   import com.goodgamestudios.basic.model.BasicModel;
   import com.goodgamestudios.basic.view.BasicProperties;
   
   public class BasicStandardYesNoDialogProperties extends BasicProperties
   {
       
      
      public var buttonLabel_yes:String = "Yes";
      
      public var buttonLabel_no:String = "No";
      
      public var copy:String = "";
      
      public var title:String = "";
      
      public var functionYes:Function;
      
      public var functionNo:Function;
      
      public var functionClose:Function;
      
      public function BasicStandardYesNoDialogProperties(param1:String, param2:String, param3:Function = null, param4:Function = null, param5:Function = null, param6:String = "", param7:String = "")
      {
         this.functionClose = param5;
         this.functionYes = param3;
         this.functionNo = param4;
         if(param6.length > 0)
         {
            this.buttonLabel_yes = param6;
         }
         else
         {
            this.buttonLabel_yes = this.delegateText(GenericTextIds.BUTTON_YES);
         }
         if(param7.length > 0)
         {
            this.buttonLabel_no = param7;
         }
         else
         {
            this.buttonLabel_no = this.delegateText(GenericTextIds.BUTTON_NO);
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
