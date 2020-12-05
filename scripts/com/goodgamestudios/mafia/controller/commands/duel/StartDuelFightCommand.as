package com.goodgamestudios.mafia.controller.commands.duel
{
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.basic.view.dialogs.BasicStandardOkDialogProperties;
   import com.goodgamestudios.basic.view.dialogs.BasicStandardYesNoDialogProperties;
   import com.goodgamestudios.mafia.constants.enums.FightType;
   import com.goodgamestudios.mafia.constants.enums.ItemType;
   import com.goodgamestudios.mafia.controller.BasicProtobufCommand;
   import com.goodgamestudios.mafia.controller.MafiaFightController;
   import com.goodgamestudios.mafia.controller.ProtobufController;
   import com.goodgamestudios.mafia.controller.protobuf.common.PBItemSlot;
   import com.goodgamestudios.mafia.controller.protobuf.fight.startduel.PBFightStartDuelRequest;
   import com.goodgamestudios.mafia.controller.protobuf.fight.startduel.PBFightStartDuelResponse;
   import com.goodgamestudios.mafia.controller.protobuf.fight.startduel.response.PBFightStartDuelResult;
   import com.goodgamestudios.mafia.event.model.MafiaDuelEvent;
   import com.goodgamestudios.mafia.event.model.MafiaUserEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.MafiaDialogHandler;
   import com.goodgamestudios.mafia.model.components.user.MafiaArmamentData;
   import com.goodgamestudios.mafia.view.dialogs.MafiaNoGoldDialog;
   import com.goodgamestudios.mafia.view.dialogs.MafiaStandardOkDialog;
   import com.goodgamestudios.mafia.view.dialogs.MafiaStandardYesNoDialog;
   import com.goodgamestudios.mafia.vo.items.ItemVO;
   import com.goodgamestudios.mafia.vo.items.components.ArmamentItemComponent;
   import com.netease.protobuf.Message;
   
   public class StartDuelFightCommand extends BasicProtobufCommand
   {
       
      
      public function StartDuelFightCommand()
      {
         super();
      }
      
      public static function sendCommand(param1:uint, param2:Boolean, param3:MafiaArmamentData) : void
      {
         var _loc5_:Array = null;
         var _loc6_:ItemVO = null;
         var _loc7_:ArmamentItemComponent = null;
         var _loc8_:PBItemSlot = null;
         var _loc4_:PBFightStartDuelRequest = new PBFightStartDuelRequest();
         _loc4_.opponentId = param1;
         _loc4_.disableConsumables = !param2;
         _loc4_.armamentNumber = MafiaModel.userData.armamentPresetData.activeArmament;
         if(param2)
         {
            _loc5_ = new Array();
            for each(_loc6_ in param3.getItems())
            {
               if(_loc6_.type == ItemType.Consumable)
               {
                  _loc7_ = _loc6_.getComponent(ArmamentItemComponent) as ArmamentItemComponent;
                  _loc8_ = new PBItemSlot();
                  _loc8_.slotX = _loc7_.xInGrid;
                  _loc8_.slotY = _loc7_.yInGrid;
                  _loc5_.push(_loc8_);
               }
            }
            _loc4_.consumableSlots = _loc5_;
         }
         ProtobufController.getInstance().sendRequest(_loc4_);
      }
      
      override public function executeCommand(param1:Message) : Boolean
      {
         var _loc2_:PBFightStartDuelResponse = param1 as PBFightStartDuelResponse;
         switch(_loc2_.result)
         {
            case PBFightStartDuelResult.OK:
               MafiaDialogHandler.getInstance().blockDialogs = true;
               MafiaModel.userData.duelData.pvpData.createDuelResultData(_loc2_.fight,_loc2_.reward);
               BasicController.getInstance().dispatchEvent(new MafiaDuelEvent(MafiaDuelEvent.CHANGE_DUEL_RESULT));
               MafiaFightController.getInstance().startFight(MafiaModel.userData.duelData.pvpData.duelResultData,FightType.Duel);
               return true;
            case PBFightStartDuelResult.ARMAMENT_CHANGED:
               MafiaDialogHandler.getInstance().blockDialogs = false;
               layoutManager.showDialog(MafiaStandardYesNoDialog.NAME,new BasicStandardYesNoDialogProperties(MafiaModel.languageData.getTextById("MafiaPreFightScreen_6"),MafiaModel.languageData.getTextById("MafiaPreFightScreen_7"),this.backToPrecombatScreen,this.attackAgain,null,MafiaModel.languageData.getTextById("MafiaPreFightScreen_2"),MafiaModel.languageData.getTextById("MafiaPreFightScreen_1")));
               break;
            case PBFightStartDuelResult.NOT_ENOUGH_GOLD:
               MafiaDialogHandler.getInstance().blockDialogs = false;
               layoutManager.showDialog(MafiaNoGoldDialog.NAME,new BasicStandardYesNoDialogProperties(MafiaModel.languageData.getTextById("MafiaNoMoneyDialog_title"),MafiaModel.languageData.getTextById("MafiaNoMoneyForFastDuel_copy"),controller.onClickMoreMoney,null,null,MafiaModel.languageData.getTextById("MafiaPaymentDialog_btn_buygold"),MafiaModel.languageData.getTextById("generic_btn_close")));
               break;
            case PBFightStartDuelResult.PLAYER_NOT_EXISTS:
               MafiaDialogHandler.getInstance().blockDialogs = false;
               layoutManager.showDialog(MafiaStandardOkDialog.NAME,new BasicStandardOkDialogProperties(MafiaModel.languageData.getTextById("MafiaDuelScreen_title"),MafiaModel.languageData.getTextById("MafiaDuelScreen_copy_3",[MafiaModel.userData.duelData.pvpData.lastDuelEnemy])));
               break;
            case PBFightStartDuelResult.MAX_ATTACK_COUNT_REACHED:
               MafiaDialogHandler.getInstance().blockDialogs = false;
               layoutManager.showDialog(MafiaStandardOkDialog.NAME,new BasicStandardOkDialogProperties(MafiaModel.languageData.getTextById("MafiaDuelScreen_title"),MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_toomanyattacks",[MafiaModel.userData.duelData.pvpData.lastDuelEnemy,_loc2_.maxAttacks])));
         }
         BasicController.getInstance().dispatchEvent(new MafiaDuelEvent(MafiaDuelEvent.DUEL_REJECTED));
         return false;
      }
      
      private function attackAgain(param1:*) : void
      {
         sendCommand(MafiaModel.userData.preCombatData.opponentId,MafiaModel.userData.preCombatData.lastUsedConsumables,MafiaModel.userData.armament);
      }
      
      private function backToPrecombatScreen(param1:*) : void
      {
         controller.dispatchEvent(new MafiaUserEvent(MafiaUserEvent.BACK_TO_PRECOMBAT));
      }
      
      override public function getRequestClass() : Class
      {
         return PBFightStartDuelRequest;
      }
      
      override public function getResponseClass() : Class
      {
         return PBFightStartDuelResponse;
      }
   }
}
