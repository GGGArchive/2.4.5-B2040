package com.goodgamestudios.mafia.view.screens
{
   import com.goodgamestudios.basic.view.BasicCustomCursor;
   import com.goodgamestudios.mafia.constants.Constants_Basic;
   import com.goodgamestudios.mafia.constants.Constants_LayoutStates;
   import com.goodgamestudios.mafia.constants.Constants_SFS;
   import com.goodgamestudios.mafia.controller.MafiaTutorialController;
   import com.goodgamestudios.mafia.controller.commands.clan.ShowClanCommand;
   import com.goodgamestudios.mafia.event.MafiaTutorialEvent;
   import com.goodgamestudios.mafia.event.model.MafiaPoliceEvent;
   import com.goodgamestudios.mafia.event.model.MafiaUserEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.MafiaDialogHandler;
   import com.goodgamestudios.mafia.model.components.user.MafiaPoliceData;
   import com.goodgamestudios.mafia.model.components.user.MafiaProfileData;
   import com.goodgamestudios.mafia.view.dialogs.MafiaPolicePostBailDialog;
   import com.goodgamestudios.mafia.view.screens.inventory.MafiaInventoryComponent;
   import com.goodgamestudios.mafia.view.tooltips.MafiaMultiLineAdvancedTooltip;
   import com.goodgamestudios.mafia.view.tooltips.MafiaPushAttributAdvancedTooltip;
   import com.goodgamestudios.mafia.view.tooltips.properties.MafiaMultiLineAdvancedTooltipProperties;
   import com.goodgamestudios.mafia.vo.TooltipVO;
   import com.goodgamestudios.mafia.vo.items.ItemVO;
   import com.goodgamestudios.stringhelper.TimeStringHelper;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class MafiaUserProfileScreen extends MafiaProfileScreen
   {
      
      public static const NAME:String = "MafiaUserProfileScreen";
       
      
      private const TUTORIAL_WEAPON_INDEX:int = 1;
      
      private const TUTORIAL_FLASHBANG_INDEX:int = 1;
      
      private var inventory:MafiaInventoryComponent;
      
      public function MafiaUserProfileScreen(param1:DisplayObject)
      {
         super(param1);
         this.inventory = new MafiaInventoryComponent(this.mafiaProfile.inventory,5,true);
         this.mafiaProfile.btn_change_avatar.toolTipText = MafiaModel.languageData.getTextById("tt_MafiaAvatarScreen_avatar");
      }
      
      override public function show() : void
      {
         super.show();
         this.inventory.show();
         this.fillAll();
         controller.addEventListener(MafiaUserEvent.CHANGE_OWN_USER_AVATAR_DATA,this.onChangeUserAvatarData);
         controller.addEventListener(MafiaUserEvent.CHANGE_OWN_USER_ATTRIBUTE_COSTS_DATA,this.onChangeUserAttributeCostsData);
         controller.addEventListener(MafiaPoliceEvent.CHANGE_POLICE_STATUS,this.onChangePoliceStatus);
         controller.addEventListener(MafiaPoliceEvent.CHANGE_POLICE_EFFECT_TIMER,this.onChangePoliceStatus);
      }
      
      override public function hide() : void
      {
         this.inventory.hide();
         super.hide();
         controller.removeEventListener(MafiaUserEvent.CHANGE_OWN_USER_AVATAR_DATA,this.onChangeUserAvatarData);
         controller.removeEventListener(MafiaUserEvent.CHANGE_OWN_USER_ATTRIBUTE_COSTS_DATA,this.onChangeUserAttributeCostsData);
         controller.removeEventListener(MafiaPoliceEvent.CHANGE_POLICE_STATUS,this.onChangePoliceStatus);
         controller.removeEventListener(MafiaPoliceEvent.CHANGE_POLICE_EFFECT_TIMER,this.onChangePoliceStatus);
      }
      
      override public function destroy() : void
      {
         this.inventory.destroy();
         super.destroy();
      }
      
      private function fillAll() : void
      {
         fillAvatarStats(MafiaModel.userData.profileData);
         this.fillPolice(MafiaModel.userData.policeData);
         this.mafiaProfile.btn_toFamily.visible = MafiaModel.userData.profileData.clanID > 0 && MafiaModel.userData.profileData.clanID < Constants_Basic.LOOKING_FOR_CLAN_ID;
      }
      
      public function fillPolice(param1:MafiaPoliceData) : void
      {
         var _loc2_:TooltipVO = null;
         mafiaBasicProfile.mc_policePenalty.visible = false;
         mafiaBasicProfile.mc_policebonus.visible = false;
         mafiaBasicProfile.mc_policePenalty.bg.mouseChildren = false;
         mafiaBasicProfile.mc_policebonus.mouseChildren = false;
         if(param1.isEffectActive())
         {
            if(param1.isRewardActive())
            {
               mafiaBasicProfile.mc_policebonus.visible = true;
               mafiaBasicProfile.mc_policebonus.toolTipVO = new TooltipVO(MafiaMultiLineAdvancedTooltip.NAME,new MafiaMultiLineAdvancedTooltipProperties(param1.getEffectDescription()));
               mafiaBasicProfile.mc_policebonus.txt_time_left.text = TimeStringHelper.getShortTimeString(param1.activeEffectTimeLeft);
            }
            else
            {
               mafiaBasicProfile.mc_policePenalty.visible = true;
               _loc2_ = new TooltipVO(MafiaMultiLineAdvancedTooltip.NAME,new MafiaMultiLineAdvancedTooltipProperties(param1.getEffectDescription() + "\n" + MafiaModel.languageData.getTextById("tt_MafiaPolice_effect_penalty_bail")));
               mafiaBasicProfile.mc_policePenalty.bg.toolTipVO = _loc2_;
               mafiaBasicProfile.mc_policePenalty.btn_bailout.toolTipVO = _loc2_;
               mafiaBasicProfile.mc_policePenalty.bg.txt_time_left.text = TimeStringHelper.getShortTimeString(param1.activeEffectTimeLeft);
            }
         }
      }
      
      override protected function onResetTutorialStep(param1:MafiaTutorialEvent) : void
      {
         switch(MafiaTutorialController.getInstance().tutorialState)
         {
            case MafiaTutorialController.TUT_STATE_DRAG_WEAPON:
            case MafiaTutorialController.TUT_STATE_DRAG_DYNAMITE:
            case MafiaTutorialController.TUT_STATE_INVENTORY_DRAG_DYNAMITE:
               MafiaTutorialController.getInstance().previousStep();
         }
      }
      
      override protected function onTutorialEvent(param1:MafiaTutorialEvent) : void
      {
         super.onTutorialEvent(param1);
         switch(MafiaTutorialController.getInstance().tutorialState)
         {
            case MafiaTutorialController.TUT_STATE_SELECT_WEAPON:
               this.mafiaProfile.tutpoint_12.addChild(MafiaTutorialController.getInstance().tutorialArrow);
               MafiaTutorialController.getInstance().flipArrow();
               break;
            case MafiaTutorialController.TUT_STATE_INVENTORY_SELECT_DYNAMITE:
               this.mafiaProfile.tutpoint_12.addChild(MafiaTutorialController.getInstance().tutorialArrow);
               MafiaTutorialController.getInstance().flipArrow();
               break;
            case MafiaTutorialController.TUT_STATE_DRAG_DYNAMITE:
               this.mafiaProfile.tutpoint_12.addChild(MafiaTutorialController.getInstance().tutorialArrow);
               break;
            case MafiaTutorialController.TUT_STATE_UPGRADE_ATTRIBUTES_1:
            case MafiaTutorialController.TUT_STATE_UPGRADE_ATTRIBUTES_2:
            case MafiaTutorialController.TUT_STATE_UPGRADE_ATTRIBUTES_3:
               this.mafiaProfile.tutpoint_14.addChild(MafiaTutorialController.getInstance().tutorialArrow);
               MafiaTutorialController.getInstance().flipArrow();
         }
      }
      
      protected function onChangePoliceStatus(param1:Event) : void
      {
         this.fillPolice(MafiaModel.userData.policeData);
      }
      
      override protected function onChangeUserData(param1:MafiaUserEvent) : void
      {
      }
      
      private function onChangeUserAvatarData(param1:MafiaUserEvent) : void
      {
         super.fillAvatarStats(MafiaModel.userData.profileData);
      }
      
      private function onChangeUserAttributeCostsData(param1:MafiaUserEvent) : void
      {
         if(layoutManager.tooltipManager.getToolTip(MafiaPushAttributAdvancedTooltip.NAME))
         {
            (layoutManager.tooltipManager.getToolTip(MafiaPushAttributAdvancedTooltip.NAME) as MafiaPushAttributAdvancedTooltip).cost(MafiaModel.userData.attributsCostsData);
         }
         this.fillStatResults(MafiaModel.userData.profileData);
      }
      
      override protected function fillStatResults(param1:MafiaProfileData) : void
      {
         if(!isBoostingAttribute)
         {
            super.fillStatResults(param1);
         }
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         switch(param1.target)
         {
            case this.mafiaProfile.btn_change_avatar:
               if(!MafiaTutorialController.getInstance().isActive)
               {
                  MafiaModel.smartfoxClient.sendMessage(Constants_SFS.C2S_GET_UNLOCKED_ASSETS,[]);
               }
               break;
            case this.mafiaProfile.defence:
               break;
            case this.mafiaProfile.btn_toFamily:
               if(MafiaModel.userData.profileData.clanID > 0 && MafiaModel.userData.profileData.clanID < Constants_Basic.LOOKING_FOR_CLAN_ID)
               {
                  layoutManager.state = Constants_LayoutStates.STATE_USERCLAN;
                  ShowClanCommand.sendCommand();
               }
               break;
            case mafiaBasicProfile.mc_policePenalty.bg:
            case mafiaBasicProfile.mc_policePenalty.btn_bailout:
               MafiaDialogHandler.getInstance().registerDialogs(MafiaPolicePostBailDialog.NAME);
         }
         super.onClick(param1);
      }
      
      override protected function onMouseOver(param1:MouseEvent) : void
      {
         var _loc2_:Inventory = null;
         var _loc3_:MovieClip = null;
         if(layoutManager.dragManager.dragVO)
         {
            return;
         }
         if(param1.target is Inventory)
         {
            _loc2_ = param1.target as Inventory;
            if(_loc2_.item.numChildren > 0)
            {
               _loc3_ = _loc2_.item.getChildAt(0) as MovieClip;
            }
            if(!_loc3_)
            {
               return;
            }
            if(_loc3_.properties is ItemVO)
            {
               controller.dispatchEvent(new MafiaUserEvent(MafiaUserEvent.CHANGE_EQUIP_HELP,[_loc3_.properties.type,_loc3_.properties.subtype,_loc3_.properties.id]));
            }
         }
         super.onMouseOver(param1);
      }
      
      override protected function onMouseOut(param1:MouseEvent) : void
      {
         if(layoutManager.dragManager.dragVO)
         {
            super.onMouseOut(param1);
            return;
         }
         layoutManager.customCursor.setCursorType(BasicCustomCursor.CURSOR_ARROW);
         controller.dispatchEvent(new MafiaUserEvent(MafiaUserEvent.CHANGE_EQUIP_HELP,[null,null,null]));
         super.onMouseOut(param1);
      }
      
      protected function get mafiaProfile() : MafiaOwnProfile
      {
         return disp as MafiaOwnProfile;
      }
   }
}
