package com.goodgamestudios.mafia.view.helper
{
   import com.goodgamestudios.graphics.utils.MovieClipHelper;
   import com.goodgamestudios.mafia.model.components.user.MafiaClanData;
   import com.goodgamestudios.mafia.vo.clan.ClanMemberVO;
   import flash.display.MovieClip;
   
   public class OnlineClanMembersHelper extends ChatHelper
   {
      
      private static const MEMBERITEM_HEIGHT:Number = 13.15;
      
      private static const MAX_MEMBERS_IN_VIEW:int = 15;
       
      
      public function OnlineClanMembersHelper(param1:MovieClip)
      {
         super(param1);
         chatslider.StepSize = 2;
      }
      
      public function fillOnlineList(param1:MafiaClanData) : void
      {
         var _loc3_:ClanMemberVO = null;
         var _loc4_:ClanChatOnlineMemberItem = null;
         if(param1.members.length <= MAX_MEMBERS_IN_VIEW)
         {
            enableSliderButtons(false);
         }
         else
         {
            enableSliderButtons(true);
         }
         MovieClipHelper.clearMovieClip(_chatkomponent.mc_textholder);
         var _loc2_:Number = 0;
         for each(_loc3_ in param1.members)
         {
            if(_loc3_.isOnline)
            {
               _loc4_ = new ClanChatOnlineMemberItem();
               _loc4_.mouseChildren = false;
               _loc4_.txt_value.text = _loc3_.name;
               _loc4_.txt_value.width = chatkomponent.mc_mask.width;
               _loc4_.properties = _loc3_;
               _loc4_.y = _loc2_;
               _loc2_ = _loc2_ + MEMBERITEM_HEIGHT;
               _chatkomponent.mc_textholder.addChild(_loc4_);
               chatHeight = chatkomponent.mc_textholder.height;
            }
         }
         scrollToEnd();
      }
      
      override public function show() : void
      {
         super.show();
      }
      
      override public function hide() : void
      {
         super.hide();
      }
      
      override public function init() : void
      {
         chatHeight = 0;
         MovieClipHelper.clearMovieClip(_chatkomponent.mc_textholder);
         _chatkomponent.mc_textholder.y = _chatkomponent.mc_mask.y;
      }
   }
}
