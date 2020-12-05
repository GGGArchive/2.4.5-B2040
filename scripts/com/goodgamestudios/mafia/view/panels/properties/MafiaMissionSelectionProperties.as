package com.goodgamestudios.mafia.view.panels.properties
{
   import com.goodgamestudios.basic.view.BasicProperties;
   import com.goodgamestudios.mafia.vo.MissionVO;
   
   public class MafiaMissionSelectionProperties extends BasicProperties
   {
       
      
      public var buttonLabel_yes:String = "Yes";
      
      public var buttonLabel_no:String = "No";
      
      public var missionVO:MissionVO;
      
      public var functionYes:Function;
      
      public var functionNo:Function;
      
      public function MafiaMissionSelectionProperties(param1:MissionVO, param2:String = "Yes", param3:String = "No", param4:Function = null, param5:Function = null)
      {
         this.functionYes = param4;
         this.functionNo = param5;
         this.buttonLabel_yes = param2;
         this.buttonLabel_no = param3;
         this.missionVO = param1;
         super();
      }
   }
}
