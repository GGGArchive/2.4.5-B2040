package com.goodgamestudios.mafia.controller.commands.specialevent.calendar
{
   import com.goodgamestudios.basic.view.dialogs.BasicStandardYesNoDialogProperties;
   import com.goodgamestudios.mafia.controller.BasicProtobufCommand;
   import com.goodgamestudios.mafia.controller.ProtobufController;
   import com.goodgamestudios.mafia.controller.protobuf.specialevent.calendar.unlocknextday.PBSpecialeventCalendarUnlockNextDayRequest;
   import com.goodgamestudios.mafia.controller.protobuf.specialevent.calendar.unlocknextday.PBSpecialeventCalendarUnlockNextDayResponse;
   import com.goodgamestudios.mafia.controller.protobuf.specialevent.calendar.unlocknextday.response.PBSpecialeventCalendarUnlockNextDayResult;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.view.dialogs.MafiaNoGoldDialog;
   import com.netease.protobuf.Message;
   
   public class UnlockNextDayCommand extends BasicProtobufCommand
   {
       
      
      public function UnlockNextDayCommand()
      {
         super();
      }
      
      public static function sendCommand() : void
      {
         var _loc1_:PBSpecialeventCalendarUnlockNextDayRequest = new PBSpecialeventCalendarUnlockNextDayRequest();
         ProtobufController.getInstance().sendRequest(_loc1_);
      }
      
      override public function executeCommand(param1:Message) : Boolean
      {
         var _loc2_:PBSpecialeventCalendarUnlockNextDayResponse = param1 as PBSpecialeventCalendarUnlockNextDayResponse;
         switch(_loc2_.result)
         {
            case PBSpecialeventCalendarUnlockNextDayResult.OK:
               return true;
            case PBSpecialeventCalendarUnlockNextDayResult.CANNOT_AFFORD:
               layoutManager.showDialog(MafiaNoGoldDialog.NAME,new BasicStandardYesNoDialogProperties(MafiaModel.languageData.getTextById("MafiaNoMoneyDialog_title"),MafiaModel.languageData.getTextById("MafiaNoMoneyForEddyFrostUnlock_copy"),controller.onClickMoreMoney,null,null,MafiaModel.languageData.getTextById("MafiaPaymentDialog_btn_buygold"),MafiaModel.languageData.getTextById("generic_btn_close")));
               break;
            case PBSpecialeventCalendarUnlockNextDayResult.EVENT_NOT_ACTIVE:
         }
         return true;
      }
      
      override public function getRequestClass() : Class
      {
         return PBSpecialeventCalendarUnlockNextDayRequest;
      }
      
      override public function getResponseClass() : Class
      {
         return PBSpecialeventCalendarUnlockNextDayResponse;
      }
   }
}
