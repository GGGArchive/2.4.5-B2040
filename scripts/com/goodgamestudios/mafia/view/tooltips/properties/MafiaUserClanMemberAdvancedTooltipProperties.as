package com.goodgamestudios.mafia.view.tooltips.properties
{
   import com.goodgamestudios.mafia.vo.clan.ClanMemberVO;
   
   public class MafiaUserClanMemberAdvancedTooltipProperties extends MafiaAdvancedTooltipProperties
   {
       
      
      public var member:ClanMemberVO;
      
      public function MafiaUserClanMemberAdvancedTooltipProperties(param1:ClanMemberVO)
      {
         this.member = param1;
         super();
      }
   }
}
