package com.goodgamestudios.mafia.view.screens
{
   import com.goodgamestudios.mafia.controller.commands.clan.InitiateClanWarCommand;
   import com.goodgamestudios.mafia.event.model.MafiaClanEvent;
   import com.goodgamestudios.mafia.event.model.MafiaEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.user.MafiaClanData;
   import com.goodgamestudios.mafia.view.NewBasicInterfaceButton;
   import com.goodgamestudios.mafia.vo.clan.FamilyCrestVO;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   
   public class MafiaOtherClanScreen extends MafiaClanScreen
   {
      
      public static const NAME:String = "MafiaOtherClanScreen";
       
      
      public function MafiaOtherClanScreen(param1:DisplayObject)
      {
         super(param1);
         controller.addEventListener(MafiaClanEvent.CHANGE_OTHERCLAN,this.onClanData);
         clan.troopWarInfo.btn_defend.enableButton = false;
         clan.donate.btn_donate.enableButton = false;
         clan.statuschat.visible = clan.troupchat.visible = clan.donate.visible = clan.pinboard.visible = false;
         clan.basicInfo.btn_details.visible = false;
         clan.basicInfo.btn_forum.visible = false;
         clan.bonusInfo.visible = false;
         clan.basicInfo.txt_familyCashBonusTitle.text = MafiaModel.languageData.getTextById("MafiaFamilyScreen_text_6");
         clan.basicInfo.txt_familyXPBonusTitle.text = MafiaModel.languageData.getTextById("MafiaFamilyScreen_text_5");
      }
      
      override public function show() : void
      {
         super.show();
         this.clearClan();
      }
      
      override public function destroy() : void
      {
         super.destroy();
         controller.removeEventListener(MafiaClanEvent.CHANGE_OTHERCLAN,this.onClanData);
      }
      
      protected function clearClan() : void
      {
         var _loc2_:ClanMemberLine = null;
         var _loc1_:uint = 0;
         while(_loc1_ < MAX_MEMBERS)
         {
            _loc2_ = clan.members.list["member" + _loc1_] as ClanMemberLine;
            resetMemberLine(_loc2_);
            _loc1_++;
         }
      }
      
      override protected function onClanData(param1:MafiaEvent) : void
      {
         this.fillClan(MafiaModel.userData.otherClan);
      }
      
      override protected function fillClan(param1:MafiaClanData) : void
      {
         clan.troopWarInfo.txt_defendTime.text = "";
         clan.troopWarInfo.txt_attackTime.text = "";
         MafiaModel.userData.userClan.lastViewedClan = param1.clanName;
         super.fillClan(param1);
         super.fillClanMembers(param1);
         var _loc2_:Boolean = MafiaModel.userData.profileData.isClanMember && MafiaModel.userData.userClan.attackingAnotherClanID <= 0 && MafiaModel.userData.profileData.rankInClan.index < 4 && param1.defendingAgainstClanID == 0;
         clan.troopWarInfo.btn_attack.enableButton = _loc2_;
         if(_loc2_)
         {
            clan.troopWarInfo.btn_attack.toolTipText = MafiaModel.languageData.getTextById("tt_MafiaFamilyScreen_btn_attack");
         }
      }
      
      override protected function onMouseDown(param1:MouseEvent) : void
      {
         switch(param1.target)
         {
            case clan.troopWarInfo.btn_attack:
               if((param1.target as NewBasicInterfaceButton).enabled)
               {
                  InitiateClanWarCommand.sendCommand(MafiaModel.userData.otherClan.clanId);
               }
               break;
            default:
               super.onMouseDown(param1);
         }
      }
      
      override protected function get crestVO() : FamilyCrestVO
      {
         return MafiaModel.userData.otherClan.familyCrest;
      }
   }
}
