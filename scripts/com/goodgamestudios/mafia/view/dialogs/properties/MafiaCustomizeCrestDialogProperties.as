package com.goodgamestudios.mafia.view.dialogs.properties
{
   import com.goodgamestudios.basic.view.BasicProperties;
   import com.goodgamestudios.mafia.vo.clan.FamilyCrestVO;
   
   public class MafiaCustomizeCrestDialogProperties extends BasicProperties
   {
       
      
      public var crestVO:FamilyCrestVO;
      
      public function MafiaCustomizeCrestDialogProperties(param1:FamilyCrestVO)
      {
         this.crestVO = param1;
         super();
      }
   }
}
