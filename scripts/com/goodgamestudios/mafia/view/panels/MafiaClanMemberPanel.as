package com.goodgamestudios.mafia.view.panels
{
   import com.goodgamestudios.basic.view.BasicCustomCursor;
   import com.goodgamestudios.basic.view.BasicToolTipManager;
   import com.goodgamestudios.basic.view.dialogs.BasicStandardYesNoDialogProperties;
   import com.goodgamestudios.mafia.constants.Constants_Basic;
   import com.goodgamestudios.mafia.constants.Constants_LayoutStates;
   import com.goodgamestudios.mafia.constants.enums.ChangeClanMemberType;
   import com.goodgamestudios.mafia.constants.enums.FamilyRank;
   import com.goodgamestudios.mafia.controller.commands.clan.ChangeFamilyMemberStatusCommand;
   import com.goodgamestudios.mafia.controller.commands.misc.PlayerProfileCommand;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.MafiaOtherUserData;
   import com.goodgamestudios.mafia.model.components.user.MafiaClanData;
   import com.goodgamestudios.mafia.view.NewBasicInterfaceButton;
   import com.goodgamestudios.mafia.view.dialogs.MafiaStandardYesNoDialog;
   import com.goodgamestudios.mafia.view.panels.properties.MafiaTroopMemberPanelProperties;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.filters.DropShadowFilter;
   
   public class MafiaClanMemberPanel extends MafiaPanel
   {
      
      public static const NAME:String = "MafiaClanMemberPanel";
       
      
      private var layerFilter:DropShadowFilter;
      
      public function MafiaClanMemberPanel(param1:DisplayObject)
      {
         this.layerFilter = new DropShadowFilter(4.2,45,0,0.5,15,15,1,1);
         super(param1);
         index = PANEL_INDEX_TROOPMEMBER;
         this.panel.btn_kick.toolTipText = MafiaModel.languageData.getTextById("tt_MafiaFamilyScreen_btn_kick");
         this.panel.btn_degrade.toolTipText = MafiaModel.languageData.getTextById("tt_MafiaFamilyScreen_btn_demote");
         this.panel.btn_push.toolTipText = MafiaModel.languageData.getTextById("tt_MafiaFamilyScreen_btn_promote");
         this.panel.btn_view.toolTipText = MafiaModel.languageData.getTextById("tt_MafiaFamilyScreen_btn_memberdetail");
      }
      
      override public function show() : void
      {
         this.panel.btn_degrade.enableButton = false;
         this.panel.btn_push.enableButton = false;
         this.panel.btn_kick.enableButton = false;
         this.panel.filters = [this.layerFilter];
         if(this.panelProperties.troopID == MafiaModel.userData.profileData.clanID)
         {
            if(this.panelProperties.playerID == MafiaModel.userData.playerID)
            {
               this.panel.btn_kick.enableButton = true;
            }
            else
            {
               switch(MafiaModel.userData.profileData.rankInClan)
               {
                  case FamilyRank.Leader:
                     this.panel.btn_degrade.enableButton = this.panelProperties.rankInClan.index < FamilyRank.Member.index;
                     this.panel.btn_push.enableButton = true;
                     this.panel.btn_kick.enableButton = true;
                     break;
                  case FamilyRank.Assistant:
                     if(this.panelProperties.rankInClan.index > FamilyRank.Assistant.index)
                     {
                        this.panel.btn_degrade.enableButton = this.panelProperties.rankInClan == FamilyRank.Officer;
                        this.panel.btn_kick.enableButton = true;
                     }
                     if(this.panelProperties.rankInClan == FamilyRank.Member)
                     {
                        this.panel.btn_push.enableButton = true;
                     }
               }
            }
         }
         super.show();
      }
      
      override public function updatePosition() : void
      {
         if(disp && disp.stage)
         {
            if(env.hasNetworkBuddies)
            {
               disp.scaleY = disp.scaleX = disp.stage.stageWidth / Constants_Basic.GAME_WIDTH;
            }
            else
            {
               disp.scaleX = disp.scaleY = disp.stage.stageHeight / Constants_Basic.GAME_HEIGHT;
            }
            disp.y = 0 + (this.panelProperties.target.parent.parent.y + this.panelProperties.target.parent.y + this.panelProperties.target.y - 15) * layoutManager.scaleFactor;
            disp.x = layoutManager.gameNullPoint + (this.panelProperties.target.parent.x + this.panelProperties.target.width) * disp.scaleX;
         }
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         var _loc2_:Array = new Array();
         if(param1.target is NewBasicInterfaceButton)
         {
            if(!(param1.target as NewBasicInterfaceButton).enabled)
            {
               return;
            }
         }
         super.onClick(param1);
         MafiaModel.userData.userClan.changeClanParams = new Array();
         MafiaModel.userData.userClan.changeClanParams[0] = this.panelProperties.playerID;
         switch(param1.target)
         {
            case this.panel.btn_view:
               if(this.panelProperties.playerID != MafiaModel.userData.playerID)
               {
                  MafiaModel.otherUserData = new MafiaOtherUserData();
                  layoutManager.state = Constants_LayoutStates.STATE_OTHERPROFILE;
               }
               else
               {
                  layoutManager.state = Constants_LayoutStates.STATE_PROFILE;
               }
               PlayerProfileCommand.sendCommand(this.panelProperties.playerID,false);
               break;
            case this.panel.btn_kick:
               if(this.panelProperties.playerID == MafiaModel.userData.playerID)
               {
                  layoutManager.showDialog(MafiaStandardYesNoDialog.NAME,new BasicStandardYesNoDialogProperties(MafiaModel.languageData.getTextById("generic_alert_watchout"),MafiaModel.languageData.getTextById("MafiaFamilyScreen_copy_10"),this.leaveTroop,null,null,MafiaModel.languageData.getTextById("generic_btn_yes"),MafiaModel.languageData.getTextById("generic_btn_no")));
               }
               else
               {
                  layoutManager.showDialog(MafiaStandardYesNoDialog.NAME,new BasicStandardYesNoDialogProperties(MafiaModel.languageData.getTextById("generic_alert_watchout"),MafiaModel.languageData.getTextById("MafiaFamilyDialog_copy_1",[this.panelProperties.name]),this.leaveTroop,null,null,MafiaModel.languageData.getTextById("generic_btn_yes"),MafiaModel.languageData.getTextById("generic_btn_no")));
               }
               break;
            case this.panel.btn_degrade:
               _loc2_.push(this.panelProperties.playerID);
               if(this.panelProperties.rankInClan == FamilyRank.Officer)
               {
                  _loc2_.push(ChangeClanMemberType.normal);
                  MafiaModel.userData.userClan.changeClanParams[1] = ChangeClanMemberType.normal;
               }
               else if(this.panelProperties.rankInClan == FamilyRank.Assistant)
               {
                  _loc2_.push(ChangeClanMemberType.officer);
                  MafiaModel.userData.userClan.changeClanParams[1] = ChangeClanMemberType.officer;
               }
               else
               {
                  return;
               }
               MafiaModel.userData.userClan.changeClanParams = new Array(_loc2_[0],_loc2_[1]);
               ChangeFamilyMemberStatusCommand.sendCommand(_loc2_);
               break;
            case this.panel.btn_push:
               _loc2_.push(this.panelProperties.playerID);
               if(this.panelProperties.rankInClan == FamilyRank.Member)
               {
                  _loc2_.push(ChangeClanMemberType.officer);
                  MafiaModel.userData.userClan.changeClanParams[1] = ChangeClanMemberType.officer;
               }
               else if(this.panelProperties.rankInClan == FamilyRank.Officer)
               {
                  _loc2_.push(ChangeClanMemberType.assistant);
                  MafiaModel.userData.userClan.changeClanParams[1] = ChangeClanMemberType.assistant;
               }
               else
               {
                  if(this.panelProperties.rankInClan == FamilyRank.Assistant)
                  {
                     layoutManager.showDialog(MafiaStandardYesNoDialog.NAME,new BasicStandardYesNoDialogProperties(MafiaModel.languageData.getTextById("generic_alert_watchout"),MafiaModel.languageData.getTextById("MafiaFamilyScreen_copy_9"),this.makeMemberToLeader,null,null,MafiaModel.languageData.getTextById("generic_btn_yes"),MafiaModel.languageData.getTextById("generic_btn_no")));
                     return;
                  }
                  return;
               }
               ChangeFamilyMemberStatusCommand.sendCommand(_loc2_);
         }
         layoutManager.hidePanel(MafiaClanMemberPanel.NAME);
      }
      
      private function makeMemberToLeader(param1:Array = null) : void
      {
         MafiaModel.userData.userClan.changeClanParams = new Array(this.panelProperties.playerID,ChangeClanMemberType.leader);
         ChangeFamilyMemberStatusCommand.sendCommand([this.panelProperties.playerID,ChangeClanMemberType.leader]);
         layoutManager.hidePanel(MafiaClanMemberPanel.NAME);
      }
      
      private function leaveTroop(param1:Array = null) : void
      {
         if(this.panelProperties.playerID == MafiaModel.userData.playerID)
         {
            MafiaModel.userData.userClan = new MafiaClanData();
            MafiaModel.userData.userClan.changeClanParams = new Array(this.panelProperties.playerID,ChangeClanMemberType.kick);
         }
         ChangeFamilyMemberStatusCommand.sendCommand([this.panelProperties.playerID,ChangeClanMemberType.kick]);
         layoutManager.hidePanel(MafiaClanMemberPanel.NAME);
      }
      
      override protected function onMouseOver(param1:MouseEvent) : void
      {
         switch(param1.target)
         {
            case this.panel.btn_view:
            case this.panel.btn_kick:
            case this.panel.btn_degrade:
            case this.panel.btn_push:
               if(BasicToolTipManager.TOOLTIP_LABEL in param1.target)
               {
                  layoutManager.tooltipManager.show(param1.target.toolTipText,param1.target as DisplayObject);
                  layoutManager.customCursor.setCursorType(BasicCustomCursor.CURSOR_CLICK);
               }
         }
      }
      
      override protected function onMouseOut(param1:MouseEvent) : void
      {
         if(param1.target is NewBasicInterfaceButton)
         {
            if(BasicToolTipManager.TOOLTIP_LABEL in param1.target)
            {
               layoutManager.tooltipManager.hide();
            }
         }
      }
      
      override protected function onRollOut(param1:MouseEvent) : void
      {
         switch(param1.target)
         {
            case this.panel.btn_view:
            case this.panel.btn_kick:
            case this.panel.btn_degrade:
            case this.panel.btn_push:
               layoutManager.tooltipManager.show(param1.target.toolTipText,param1.target as DisplayObject);
               break;
            default:
               super.onRollOut(param1);
               layoutManager.customCursor.setCursorType(BasicCustomCursor.CURSOR_ARROW);
               layoutManager.hidePanel(MafiaClanMemberPanel.NAME);
         }
      }
      
      protected function get panel() : MafiaClanMemberMenue
      {
         return disp as MafiaClanMemberMenue;
      }
      
      protected function get panelProperties() : MafiaTroopMemberPanelProperties
      {
         return properties as MafiaTroopMemberPanelProperties;
      }
   }
}
