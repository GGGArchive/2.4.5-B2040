package com.goodgamestudios.mafia.view.tooltips.properties
{
   import com.goodgamestudios.mafia.vo.GangVO;
   
   public class MafiaGangMemberAdvancedTooltipProperties extends MafiaAdvancedTooltipProperties
   {
       
      
      public var isShop:Boolean;
      
      public var gangMember:GangVO;
      
      public function MafiaGangMemberAdvancedTooltipProperties(param1:GangVO, param2:Boolean)
      {
         this.gangMember = param1;
         this.isShop = param2;
         super();
      }
   }
}
