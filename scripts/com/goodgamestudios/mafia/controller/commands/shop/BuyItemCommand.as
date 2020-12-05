package com.goodgamestudios.mafia.controller.commands.shop
{
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.basic.view.dialogs.BasicStandardOkDialogProperties;
   import com.goodgamestudios.basic.view.dialogs.BasicStandardYesNoDialogProperties;
   import com.goodgamestudios.mafia.constants.enums.ItemLocation;
   import com.goodgamestudios.mafia.controller.BasicProtobufCommand;
   import com.goodgamestudios.mafia.controller.MafiaSoundController;
   import com.goodgamestudios.mafia.controller.MafiaTutorialController;
   import com.goodgamestudios.mafia.controller.ProtobufController;
   import com.goodgamestudios.mafia.controller.ProtobufEnumTranslator;
   import com.goodgamestudios.mafia.controller.protobuf.common.item.PBItemQuality;
   import com.goodgamestudios.mafia.controller.protobuf.shop.buyitem.PBShopBuyItemRequest;
   import com.goodgamestudios.mafia.controller.protobuf.shop.buyitem.PBShopBuyItemResponse;
   import com.goodgamestudios.mafia.controller.protobuf.shop.buyitem.response.PBShopBuyItemResult;
   import com.goodgamestudios.mafia.event.model.MafiaShopEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.MafiaItemData;
   import com.goodgamestudios.mafia.view.dialogs.MafiaNoCashDialog;
   import com.goodgamestudios.mafia.view.dialogs.MafiaNoGoldDialog;
   import com.goodgamestudios.mafia.view.dialogs.MafiaStandardOkDialog;
   import com.goodgamestudios.mafia.view.screens.MafiaShopScreen;
   import com.goodgamestudios.mafia.vo.items.ItemVO;
   import com.goodgamestudios.stringhelper.NumberStringHelper;
   import com.netease.protobuf.Message;
   
   public class BuyItemCommand extends BasicProtobufCommand
   {
       
      
      public function BuyItemCommand()
      {
         super();
      }
      
      public static function sendCommand(param1:ItemLocation, param2:int, param3:int) : void
      {
         var _loc4_:PBShopBuyItemRequest = new PBShopBuyItemRequest();
         _loc4_.shop = ProtobufEnumTranslator.translateShopLocationToProto(param1);
         _loc4_.source = param2;
         _loc4_.target = param3;
         ProtobufController.getInstance().sendRequest(_loc4_);
      }
      
      override public function executeCommand(param1:Message) : Boolean
      {
         var _loc2_:PBShopBuyItemResponse = null;
         var _loc3_:Boolean = false;
         var _loc4_:String = null;
         var _loc5_:ItemVO = null;
         MafiaModel.userData.unlockAllItems();
         _loc2_ = param1 as PBShopBuyItemResponse;
         switch(_loc2_.result)
         {
            case PBShopBuyItemResult.OK:
               controller.soundController.playSoundEffect(MafiaSoundController.SND_SOLD);
               if(MafiaTutorialController.getInstance().isActive)
               {
                  switch(MafiaTutorialController.getInstance().tutorialState)
                  {
                     case MafiaTutorialController.TUT_STATE_SELECT_DYNAMITE:
                        MafiaTutorialController.getInstance().setStep(MafiaTutorialController.TUT_STATE_GO_TO_PROFIL);
                  }
               }
               _loc3_ = _loc2_.stacked;
               if(_loc3_)
               {
                  _loc5_ = MafiaItemData.parseItem(_loc2_.item,ItemLocation.None,0);
                  layoutManager.showDialog(MafiaStandardOkDialog.NAME,new BasicStandardOkDialogProperties(MafiaModel.languageData.getTextById("MafiaStackableDialog_merge_title"),MafiaModel.languageData.getTextById("MafiaStackableDialog_merge_copy_1",[_loc5_.amount,_loc5_.name])));
               }
               return true;
            case PBShopBuyItemResult.CANNOT_AFFORD:
               if(_loc2_.item)
               {
                  if(_loc2_.item.quality != PBItemQuality.NORMAL)
                  {
                     layoutManager.showDialog(MafiaNoGoldDialog.NAME,new BasicStandardYesNoDialogProperties(MafiaModel.languageData.getTextById("MafiaNoMoneyDialog_title"),MafiaModel.languageData.getTextById("MafiaNoMoneyForBuyItem_copy"),controller.onClickMoreMoney,null,null,MafiaModel.languageData.getTextById("MafiaPaymentDialog_btn_buygold"),MafiaModel.languageData.getTextById("generic_btn_close")));
                  }
                  else
                  {
                     layoutManager.showDialog(MafiaNoCashDialog.NAME,new BasicStandardOkDialogProperties(MafiaModel.languageData.getTextById("MafiaNoCashDialog_title"),MafiaModel.languageData.getTextById("MafiaNoCashForBuyItem_copy") + "\n" + MafiaModel.languageData.getTextById("MafiaNoCashForBuyItem_copy_2")));
                  }
               }
               break;
            case PBShopBuyItemResult.INVENTORY_SLOT_OCCUPIED:
               layoutManager.showDialog(MafiaStandardOkDialog.NAME,new BasicStandardOkDialogProperties(MafiaModel.languageData.getTextById("generic_alert_watchout"),MafiaModel.languageData.getTextById("MafiaInventoryFullDialog_copy_3")));
               break;
            case PBShopBuyItemResult.ITEM_AMOUNT_LIMIT_REACHED:
               _loc4_ = NumberStringHelper.groupString(9999,MafiaModel.languageData.getTextById);
               layoutManager.showDialog(MafiaStandardOkDialog.NAME,new BasicStandardOkDialogProperties(MafiaModel.languageData.getTextById("MafiaStackableDialog_limit_title"),MafiaModel.languageData.getTextById("MafiaStackableDialog_limit_copy_1",[_loc4_])));
               break;
            case PBShopBuyItemResult.FEATURE_INACTIVE:
               MafiaModel.userData.extrasShop.isActive = false;
               BasicController.getInstance().dispatchEvent(new MafiaShopEvent(MafiaShopEvent.CHANGE_SHOP_STATE,[MafiaShopScreen.EXTRAS,false]));
         }
         return false;
      }
      
      override public function getRequestClass() : Class
      {
         return PBShopBuyItemRequest;
      }
      
      override public function getResponseClass() : Class
      {
         return PBShopBuyItemResponse;
      }
   }
}
