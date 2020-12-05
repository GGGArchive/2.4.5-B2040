package com.goodgamestudios.mafia.model.components.user
{
   import com.goodgamestudios.basic.IEnvironmentGlobals;
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.basic.model.components.BasicDialogHandler;
   import com.goodgamestudios.basic.view.BasicLayoutManager;
   import com.goodgamestudios.mafia.MafiaEnvironmentGlobals;
   import com.goodgamestudios.mafia.constants.Constants_Basic;
   import com.goodgamestudios.mafia.event.model.MafiaOfferEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.MafiaDialogHandler;
   import com.goodgamestudios.mafia.view.MafiaLayoutManager;
   import com.goodgamestudios.mafia.view.dialogs.MafiaBonusDialog;
   import com.goodgamestudios.mafia.view.dialogs.properties.MafiaBonusDialogProperties;
   import com.goodgamestudios.mafia.vo.OfferVO;
   import com.goodgamestudios.stringhelper.TimeStringHelper;
   import flash.utils.getTimer;
   
   public class MafiaSpecialOfferData
   {
      
      public static const ID_PRIMETIME:int = 1;
      
      public static const ID_REGBONUS:int = 2;
      
      public static const ID_PRICECHANGE:int = 3;
       
      
      public var offer:OfferVO;
      
      private const SHINEDELAY:int = 60000;
      
      private const SHINEONDELAY:int = 15000;
      
      private var _shineOn:Boolean;
      
      private var nextShineTime:Number = 0;
      
      private var _initOffer:Boolean = false;
      
      public function MafiaSpecialOfferData()
      {
         super();
      }
      
      public function parseData(param1:Array) : OfferVO
      {
         param1.shift();
         var _loc2_:OfferVO = new OfferVO();
         _loc2_.percentGold = param1.shift();
         param1.shift();
         _loc2_.isUnderPrimeTimeTime = param1[0] < 5400;
         _loc2_.offerEndTimeInMs = getTimer() + parseInt(param1.shift()) * Constants_Basic.SEC2MILLISEC;
         _loc2_.offerEndTime = TimeStringHelper.getTimeToString((_loc2_.offerEndTimeInMs - getTimer()) * Constants_Basic.MILLISEC2SEC,TimeStringHelper.TWO_TIME_FORMAT,MafiaModel.languageData.getTextById);
         if(int(param1.shift()) == 0)
         {
            _loc2_.offerID = ID_PRIMETIME;
         }
         else
         {
            _loc2_.offerID = ID_REGBONUS;
         }
         if(_loc2_.percentGold == "0")
         {
            _loc2_.offerID = ID_PRICECHANGE;
         }
         return _loc2_;
      }
      
      public function handleSpecialOffer(param1:OfferVO) : void
      {
         this.offer = param1;
         if(!this.env.isBeta && !this.env.isFirstVisit)
         {
            if(!this._initOffer)
            {
               this._initOffer = true;
               this._shineOn = true;
               switch(param1.offerID)
               {
                  case 0:
                     break;
                  case ID_PRIMETIME:
                  case ID_REGBONUS:
                  case ID_PRICECHANGE:
                     MafiaDialogHandler.getInstance().registerDialogs(MafiaBonusDialog.NAME,new MafiaBonusDialogProperties(param1),true,BasicDialogHandler.PRIORITY_TOP);
               }
            }
            BasicController.getInstance().dispatchEvent(new MafiaOfferEvent(MafiaOfferEvent.CHANGE_OFFER,[MafiaModel.userData.offerData.offer.offerEndTime,MafiaModel.userData.offerData.offer.offerID,MafiaModel.userData.offerData.offer.percentGold]));
         }
         else
         {
            param1 = null;
         }
      }
      
      public function checkOfferTime(param1:Number) : void
      {
         var _loc2_:Array = null;
         if(this.offer.offerEndTimeInMs > 0)
         {
            _loc2_ = new Array();
            _loc2_.push(TimeStringHelper.getTimeToString((this.offer.offerEndTimeInMs - param1) * Constants_Basic.MILLISEC2SEC,TimeStringHelper.TWO_TIME_FORMAT,MafiaModel.languageData.getTextById));
            BasicController.getInstance().dispatchEvent(new MafiaOfferEvent(MafiaOfferEvent.CHANGE_OFFERENDTIME,_loc2_));
            if(param1 >= this.offer.offerEndTimeInMs)
            {
               this.offer.offerEndTimeInMs = 0;
            }
         }
         else
         {
            this.offer.offerEndTimeInMs = 0;
            if(this.offer.offerID != ID_PRICECHANGE && BasicLayoutManager.getInstance().getDialog(MafiaBonusDialog))
            {
               MafiaLayoutManager.getInstance().getDialog(MafiaBonusDialog).hide();
            }
         }
      }
      
      public function checkGoldShineTime(param1:Number) : void
      {
         if(this.offer.offerEndTimeInMs > 0 && param1 > this.nextShineTime && this.offer.offerID != ID_PRICECHANGE)
         {
            if(this._shineOn)
            {
               this.nextShineTime = param1 + this.SHINEONDELAY;
               BasicController.getInstance().dispatchEvent(new MafiaOfferEvent(MafiaOfferEvent.CHANGE_GOLDSHINE,[this._shineOn]));
               this._shineOn = false;
            }
            else
            {
               this.nextShineTime = param1 + this.SHINEDELAY;
               BasicController.getInstance().dispatchEvent(new MafiaOfferEvent(MafiaOfferEvent.CHANGE_GOLDSHINE,[this._shineOn]));
               this._shineOn = true;
            }
         }
      }
      
      public function set initOffer(param1:Boolean) : void
      {
         this._initOffer = param1;
      }
      
      private function get env() : IEnvironmentGlobals
      {
         return new MafiaEnvironmentGlobals();
      }
   }
}
