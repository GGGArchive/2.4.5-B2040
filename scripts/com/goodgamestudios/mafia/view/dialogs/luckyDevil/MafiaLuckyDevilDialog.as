package com.goodgamestudios.mafia.view.dialogs.luckyDevil
{
   import com.goodgamestudios.basic.view.BasicCustomCursor;
   import com.goodgamestudios.basic.view.dialogs.BasicStandardOkDialogProperties;
   import com.goodgamestudios.graphics.utils.MovieClipHelper;
   import com.goodgamestudios.mafia.constants.enums.TooltipDispPosition;
   import com.goodgamestudios.mafia.controller.commands.specialevent.LuckyDevilCommand;
   import com.goodgamestudios.mafia.controller.commands.specialevent.luckydevil.BuyCardsCommand;
   import com.goodgamestudios.mafia.controller.commands.specialevent.luckydevil.TurnCardCommand;
   import com.goodgamestudios.mafia.event.model.MafiaSpecialEventsEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.MafiaItemData;
   import com.goodgamestudios.mafia.view.MafiaLayoutManager;
   import com.goodgamestudios.mafia.view.dialogs.MafiaDialog;
   import com.goodgamestudios.mafia.view.dialogs.MafiaStandardOkDialog;
   import com.goodgamestudios.mafia.view.tooltips.MafiaItemTooltipVOCreator;
   import com.goodgamestudios.mafia.vo.items.ItemVO;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class MafiaLuckyDevilDialog extends MafiaDialog
   {
      
      public static const NAME:String = "LuckyDevilDialog";
      
      private static const STATE_NEW:String = "new";
      
      private static const STATE_CARD_SELECTION:String = "cardselection";
      
      private static const STATE_BUY_CARDS:String = "buycards";
      
      private static const CARD_COUNT:uint = 5;
       
      
      private var selectedCard:LuckyDevilCard;
      
      private var flipAnimation:MovieClip;
      
      private var cardAnimationStates:Vector.<Boolean>;
      
      private var skipDealAnimation:Boolean = false;
      
      public function MafiaLuckyDevilDialog(param1:Sprite)
      {
         super(param1);
      }
      
      override public function show() : void
      {
         super.show();
         this.setState(STATE_NEW);
         controller.addEventListener(MafiaSpecialEventsEvent.LUCKY_DEVIL_EVENT_DATA,this.onEventData);
         controller.addEventListener(MafiaSpecialEventsEvent.LUCKY_DEVIL_ITEM_RECEIVED,this.onItemReceived);
         controller.addEventListener(MafiaSpecialEventsEvent.LUCKY_DEVIL_CARDS_BOUGHT,this.onCardsBought);
         controller.addEventListener(MafiaSpecialEventsEvent.LUCKY_DEVIL_TIMER_UPDATE,this.onTimerUpdate);
         controller.addEventListener(MafiaSpecialEventsEvent.SPECIAL_EVENT_IS_OVER,this.onSpecialEventIsOver);
      }
      
      override protected function removeEvents() : void
      {
         super.removeEvents();
         controller.removeEventListener(MafiaSpecialEventsEvent.LUCKY_DEVIL_EVENT_DATA,this.onEventData);
         controller.removeEventListener(MafiaSpecialEventsEvent.LUCKY_DEVIL_ITEM_RECEIVED,this.onItemReceived);
         controller.removeEventListener(MafiaSpecialEventsEvent.LUCKY_DEVIL_CARDS_BOUGHT,this.onCardsBought);
         controller.removeEventListener(MafiaSpecialEventsEvent.LUCKY_DEVIL_TIMER_UPDATE,this.onTimerUpdate);
         controller.removeEventListener(MafiaSpecialEventsEvent.SPECIAL_EVENT_IS_OVER,this.onSpecialEventIsOver);
         this.dialog.removeEventListener(Event.ENTER_FRAME,this.onCardAnimationEnterFrame);
      }
      
      private function setState(param1:String = null) : void
      {
         switch(param1)
         {
            case STATE_BUY_CARDS:
               this.dialog.gotoAndStop(3);
               this.dialog.btn_newCards.goldInfoTimeText = MafiaModel.specialEvent.luckyDevilEvent.cost.toString();
               this.dialog.btn_newCards.goldInfoVisible = true;
               this.dialog.btn_ok.label = MafiaModel.languageData.getTextById("generic_btn_okay");
               this.dialog.btn_newCards.label = MafiaModel.languageData.getTextById("event_luckydevil_copy_9");
               updateAllTextFields();
               this.dialog.btn_ok.update();
               this.dialog.btn_newCards.update();
               break;
            case STATE_CARD_SELECTION:
               this.dialog.gotoAndStop(2);
               this.dialog.btn_buyCards.visible = false;
               this.dialog.btn_buyCards.goldInfoTimeText = MafiaModel.specialEvent.luckyDevilEvent.cost.toString();
               this.dialog.btn_buyCards.goldInfoVisible = true;
               this.dialog.txt_copy.text = MafiaModel.languageData.getTextById("event_luckydevil_copy_6");
               this.dialog.txt_copy2.text = "";
               this.dialog.btn_buyCards.label = MafiaModel.languageData.getTextById("event_luckydevil_copy_9");
               this.startDealAnimation();
               this.cardAnimationStates = new Vector.<Boolean>(CARD_COUNT);
               updateAllTextFields();
               this.dialog.btn_buyCards.update();
               break;
            case STATE_NEW:
            default:
               this.dialog.gotoAndStop(1);
               this.dialog.blingAnimation.stop();
               this.dialog.blingAnimation.mouseEnabled = false;
               this.dialog.blingAnimation.mouseChildren = false;
               this.dialog.btn_ok.label = MafiaModel.languageData.getTextById("generic_btn_okay");
               this.dialog.btn_start.label = MafiaModel.languageData.getTextById("event_luckydevil_copy_5");
               this.dialog.txt_title.text = MafiaModel.languageData.getTextById("event_luckydevil_copy_1");
               this.dialog.txt_copy.text = MafiaModel.languageData.getTextById("homescreenFeature_26_1_copy");
               updateAllTextFields();
               this.dialog.btn_ok.update();
               this.dialog.btn_start.update();
         }
         this.dialog.header.txt_sigil1.text = "100%";
         this.dialog.header.txt_sigil2.text = MafiaModel.languageData.getTextById("event_luckydevil_copy_1");
         updateAllTextFields();
      }
      
      private function startDealAnimation() : void
      {
         var _loc1_:MovieClip = null;
         if(!this.skipDealAnimation)
         {
            _loc1_ = new LuckyDevilAniDeal();
            _loc1_.x = -340;
            _loc1_.y = -249;
            this.dialog.cardHolder.addChild(_loc1_);
            MovieClipHelper.watchAnimationEnd(_loc1_,this.onDealAnimationEnd);
         }
         else
         {
            this.onDealAnimationEnd();
         }
      }
      
      private function startClearAnimation() : void
      {
         this.dialog.txt_copy.text = "";
         this.dialog.txt_copy2.text = "";
         var _loc1_:LuckyDevilAniCollect = new LuckyDevilAniCollect();
         _loc1_.x = -338;
         _loc1_.y = -249;
         this.dialog.cardHolder.addChild(_loc1_);
         MovieClipHelper.watchAnimationEnd(_loc1_,this.onClearAnimationEnd);
      }
      
      private function onDealAnimationEnd(param1:MovieClip = null) : void
      {
         var _loc5_:LuckyDevilCard = null;
         var _loc2_:Number = 121.5;
         var _loc3_:Number = -242.5;
         var _loc4_:int = CARD_COUNT;
         if(param1)
         {
            param1.parent.removeChild(param1);
         }
         while(_loc4_--)
         {
            _loc5_ = new LuckyDevilCard();
            _loc5_.mouseChildren = false;
            _loc5_.name = "card" + _loc4_;
            _loc5_.animation.gotoAndStop(1);
            _loc5_.x = _loc3_ + _loc2_ * _loc4_;
            if(this.dialog.cardHolder)
            {
               this.dialog.cardHolder.addChild(_loc5_);
            }
         }
         this.dialog.addEventListener(Event.ENTER_FRAME,this.onCardAnimationEnterFrame);
      }
      
      private function onClearAnimationEnd(param1:MovieClip) : void
      {
         param1.parent.removeChild(param1);
         BuyCardsCommand.sendCommand();
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         var _loc2_:BasicStandardOkDialogProperties = null;
         if(param1.target is TextField)
         {
            return;
         }
         switch(param1.target)
         {
            case this.dialog.btn_close:
            case this.dialog.btn_ok:
               hide();
               this.skipDealAnimation = MafiaModel.specialEvent.luckyDevilEvent.hasCards;
               break;
            case this.dialog.btn_start:
               LuckyDevilCommand.sendCommand();
               break;
            case this.dialog.btn_buyCards:
               MovieClipHelper.clearMovieClip(this.dialog.cardHolder);
               this.skipDealAnimation = false;
               this.startClearAnimation();
               break;
            case this.dialog.btn_newCards:
               BuyCardsCommand.sendCommand();
               this.skipDealAnimation = false;
               break;
            case this.flipAnimation:
               if(this.flipAnimation.toolTipVO)
               {
                  this.flipAnimation.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_OVER));
               }
               break;
            default:
               if(param1.target is LuckyDevilCard && MafiaModel.specialEvent.luckyDevilEvent.hasCards)
               {
                  if(!MafiaModel.userData.inventory.isInventoryFull)
                  {
                     TurnCardCommand.sendCommand();
                     this.selectedCard = param1.target as LuckyDevilCard;
                  }
                  else
                  {
                     _loc2_ = new BasicStandardOkDialogProperties(MafiaModel.languageData.getTextById("generic_alert_watchout"),MafiaModel.languageData.getTextById("MafiaInventoryFullDialog_copy_4"));
                     layoutManager.showDialog(MafiaStandardOkDialog.NAME,_loc2_);
                  }
               }
         }
      }
      
      override protected function onMouseOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         super.onMouseOver(param1);
         if(param1.target is LuckyDevilCard && MafiaModel.specialEvent.luckyDevilEvent.hasCards)
         {
            _loc2_ = Number(param1.target.name.substr(4));
            this.cardAnimationStates[_loc2_] = true;
            layoutManager.customCursor.setCursorType(BasicCustomCursor.CURSOR_HAND);
         }
      }
      
      override protected function onMouseOut(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         super.onMouseOut(param1);
         if(param1.target is LuckyDevilCard && MafiaModel.specialEvent.luckyDevilEvent.hasCards)
         {
            _loc2_ = Number(param1.target.name.substr(4));
            this.cardAnimationStates[_loc2_] = false;
            layoutManager.customCursor.setCursorType(BasicCustomCursor.CURSOR_ARROW);
         }
      }
      
      private function onCardAnimationEnterFrame(param1:Event) : void
      {
         var card:LuckyDevilCard = null;
         var overState:Boolean = false;
         var event:Event = param1;
         if(this.dialog.currentFrame != 2 || !this.dialog.cardHolder)
         {
            return;
         }
         var num:uint = CARD_COUNT;
         while(num--)
         {
            try
            {
               card = this.dialog.cardHolder.getChildByName("card" + num) as LuckyDevilCard;
               overState = this.cardAnimationStates[num];
               if(overState && card.animation.currentFrame < card.animation.totalFrames)
               {
                  card.animation.gotoAndStop(card.animation.currentFrame + 1);
               }
               else if(!overState && card.animation.currentFrame > 1)
               {
                  card.animation.gotoAndStop(card.animation.currentFrame - 1);
               }
            }
            catch(e:Error)
            {
               continue;
            }
         }
      }
      
      private function onEventData(param1:MafiaSpecialEventsEvent) : void
      {
         if(MafiaModel.specialEvent.luckyDevilEvent.hasCards)
         {
            this.setState(STATE_CARD_SELECTION);
         }
         else
         {
            this.setState(STATE_BUY_CARDS);
         }
      }
      
      private function onItemReceived(param1:MafiaSpecialEventsEvent) : void
      {
         var itemVO:ItemVO = null;
         var itemMC1:MovieClip = null;
         var onComplete:Function = null;
         var event:MafiaSpecialEventsEvent = param1;
         onComplete = function(param1:MovieClip):void
         {
            MafiaLayoutManager.getInstance().customCursor.setCursorType(BasicCustomCursor.CURSOR_ARROW);
            MafiaLayoutManager.getInstance().tooltipManager.hideAdvancedTooltip();
            dialog.btn_buyCards.visible = true;
            dialog.txt_copy.text = MafiaModel.languageData.getTextById("event_luckydevil_copy_7",[itemVO.amount,itemVO.name]);
            dialog.txt_copy2.text = MafiaModel.languageData.getTextById("event_luckydevil_copy_8");
            param1.toolTipVO = MafiaItemTooltipVOCreator.instance.creatTooltipVO(itemMC1.properties,TooltipDispPosition.None);
         };
         itemVO = event.params[0];
         itemMC1 = MafiaItemData.getInstance().generateItemIcon(itemVO);
         var itemMC2:MovieClip = MafiaItemData.getInstance().generateItemIcon(itemVO);
         this.flipAnimation = new LuckyDevilAniFlip();
         this.flipAnimation.mouseChildren = false;
         this.flipAnimation.gotoAndPlay(3);
         this.flipAnimation.x = this.selectedCard.x;
         this.flipAnimation.y = this.selectedCard.y + 1;
         this.flipAnimation.itemHolder1.addChild(itemMC1);
         this.flipAnimation.itemHolder2.addChild(itemMC2);
         this.dialog.cardHolder.addChild(this.flipAnimation);
         this.dialog.cardHolder.removeChild(this.selectedCard);
         this.dialog.txt_copy.text = "";
         MovieClipHelper.watchAnimationEnd(this.flipAnimation,onComplete);
      }
      
      private function onCardsBought(param1:MafiaSpecialEventsEvent) : void
      {
         if(param1.params[0] == true)
         {
            this.setState(STATE_BUY_CARDS);
            return;
         }
         this.setState(STATE_CARD_SELECTION);
      }
      
      private function onTimerUpdate(param1:MafiaSpecialEventsEvent) : void
      {
         var _loc2_:String = null;
         if(this.dialog.txt_timer)
         {
            _loc2_ = param1.params[0];
            this.dialog.txt_timer.text = MafiaModel.languageData.getTextById("event_luckydevil_copy_4") + "\n" + _loc2_;
         }
      }
      
      protected function onSpecialEventIsOver(param1:Event) : void
      {
         this.hide();
      }
      
      protected function get dialog() : EventDialog_9
      {
         return disp as EventDialog_9;
      }
   }
}
