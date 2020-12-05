package com.goodgamestudios.mafia.view.dialogs.properties
{
   import com.goodgamestudios.basic.view.BasicProperties;
   import com.goodgamestudios.mafia.vo.NewAchievementVO;
   
   public class MafiaNewAchievementDialogProperties extends BasicProperties
   {
       
      
      public var buttonLabel_ok:String = "OK";
      
      public var buttonLabel_close:String = "Close";
      
      public var title:String = "";
      
      public var functionYes:Function;
      
      public var functionNo:Function;
      
      public var newAchievementData:NewAchievementVO;
      
      public function MafiaNewAchievementDialogProperties(param1:NewAchievementVO, param2:String, param3:String = "Buy", param4:String = "Close", param5:Function = null)
      {
         this.buttonLabel_ok = param3;
         this.buttonLabel_close = param4;
         this.title = param2;
         this.newAchievementData = param1;
         this.functionYes = param5;
         super();
      }
   }
}
