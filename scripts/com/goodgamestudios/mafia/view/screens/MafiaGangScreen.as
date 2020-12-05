package com.goodgamestudios.mafia.view.screens
{
   import com.goodgamestudios.basic.view.BasicCustomCursor;
   import com.goodgamestudios.basic.view.dialogs.BasicStandardYesNoDialogProperties;
   import com.goodgamestudios.graphics.utils.MovieClipHelper;
   import com.goodgamestudios.mafia.constants.Constants_Background;
   import com.goodgamestudios.mafia.constants.Constants_LayoutStates;
   import com.goodgamestudios.mafia.constants.Constants_SFS;
   import com.goodgamestudios.mafia.event.model.MafiaGangEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.user.gang.MafiaGangData;
   import com.goodgamestudios.mafia.view.dialogs.MafiaNoGoldDialog;
   import com.goodgamestudios.mafia.view.tooltips.MafiaGangMemberAdvancedTooltip;
   import com.goodgamestudios.mafia.view.tooltips.properties.MafiaGangMemberAdvancedTooltipProperties;
   import com.goodgamestudios.mafia.vo.GangVO;
   import com.goodgamestudios.mafia.vo.TooltipVO;
   import com.goodgamestudios.stringhelper.NumberStringHelper;
   import com.goodgamestudios.stringhelper.TimeStringHelper;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class MafiaGangScreen extends MafiaScreen
   {
      
      public static const NAME:String = "MafiaGangScreen";
       
      
      private const MEMBERINSTANCENAME:String = "member";
      
      private var _gangShopIndex:int = 0;
      
      private var _hireToSlotId:int;
      
      private var _fireGangMemberSlotId:int;
      
      private var isWaitingForServerMessage:Boolean;
      
      public function MafiaGangScreen(param1:DisplayObject, param2:Boolean = true)
      {
         super(param1,param2);
      }
      
      override protected function get screenBackgroundId() : String
      {
         return MafiaModel.userData.profileData.city.index + "_" + Constants_Background.BG_FIGHT;
      }
      
      override public function show() : void
      {
         super.show();
         this.isWaitingForServerMessage = false;
         this.fillGang(MafiaModel.userData.gangData);
         if(MafiaModel.userData.gangData.shopGang)
         {
            this.fillGangShop(MafiaModel.userData.gangData.shopGang);
         }
         controller.addEventListener(MafiaGangEvent.CHANGE_OWN_USER_GANG_DATA,this.onChangeGangData);
         controller.addEventListener(MafiaGangEvent.CHANGE_OWN_USER_GANG_TIME,this.onChangeGangTimer);
         this.gangScreen.info.txt_copy.text = MafiaModel.languageData.getTextById("MafiaGangScreen_copy_6");
         this.gangScreen.btn_close.toolTipText = MafiaModel.languageData.getTextById("generic_btn_close");
         this.gangScreen.header.headerTitle.txt_header.text = MafiaModel.languageData.getTextById("MafiaGangScreen_title");
      }
      
      override protected function removeEvents() : void
      {
         controller.removeEventListener(MafiaGangEvent.CHANGE_OWN_USER_GANG_DATA,this.onChangeGangData);
         controller.removeEventListener(MafiaGangEvent.CHANGE_OWN_USER_GANG_TIME,this.onChangeGangTimer);
         super.removeEvents();
      }
      
      private function onChangeGangData(param1:MafiaGangEvent) : void
      {
         this.fillGang(MafiaModel.userData.gangData);
         this.gangScreen.hire.visible = false;
      }
      
      private function fillGang(param1:MafiaGangData) : void
      {
         var _loc4_:TextField = null;
         var _loc5_:MafiaGangMember = null;
         var _loc6_:GangVO = null;
         var _loc7_:Sprite = null;
         this.gangScreen.info.visible = true;
         this.gangScreen.fire.visible = false;
         this.gangScreen.hire.visible = false;
         this.gangScreen.bonus.txt_title.text = MafiaModel.languageData.getTextById("MafiaGangScreen_starbonus_copy_1");
         this.gangScreen.bonus.txt_copy1.text = MafiaModel.languageData.getTextById("MafiaGangScreen_starbonus_copy_2",[MafiaGangData.BONUS_AMOUNT_STAR_1]);
         this.gangScreen.bonus.txt_copy2.text = MafiaModel.languageData.getTextById("MafiaGangScreen_starbonus_copy_3",[MafiaGangData.BONUS_AMOUNT_STAR_2]);
         this.gangScreen.bonus.txt_copy3.text = MafiaModel.languageData.getTextById("MafiaGangScreen_starbonus_copy_4",[MafiaGangData.BONUS_AMOUNT_STAR_3]);
         this.gangScreen.bonus.txt_copy4.text = MafiaModel.languageData.getTextById("MafiaGangScreen_starbonus_copy_5",[MafiaGangData.BONUS_AMOUNT_STAR_4]);
         this.gangScreen.bonus.txt_copy5.text = MafiaModel.languageData.getTextById("MafiaGangScreen_starbonus_copy_6",[MafiaGangData.BONUS_AMOUNT_STAR_5]);
         var _loc2_:int = 1;
         while(_loc2_ < MafiaGangData.MAXGANGMEMBERS + 1)
         {
            _loc4_ = this.gangScreen.bonus.getChildByName("txt_copy" + _loc2_) as TextField;
            if(param1.bonusCount >= _loc2_)
            {
               _loc4_.textColor = 5196099;
            }
            else
            {
               _loc4_.textColor = 13090737;
            }
            _loc2_++;
         }
         this.gangScreen.bonus.bonusStar.gotoAndStop(param1.bonusCount + 1);
         var _loc3_:int = 0;
         while(_loc3_ < MafiaGangData.MAXGANGMEMBERS)
         {
            _loc5_ = this.gangScreen.getChildByName(this.MEMBERINSTANCENAME + _loc3_) as MafiaGangMember;
            _loc5_.inUse.visible = false;
            _loc5_.free.visible = false;
            _loc5_.locked.visible = false;
            MovieClipHelper.clearMovieClip(_loc5_.inUse.holder);
            _loc5_.inUse.toolTipVO = null;
            if(param1.playerGang.length > _loc3_)
            {
               if(param1.playerGang[_loc3_] != null)
               {
                  _loc6_ = param1.playerGang[_loc3_];
                  _loc5_.inUse.visible = true;
                  _loc5_.inUse.btn_fire.label = MafiaModel.languageData.getTextById("MafiaGangScreen_copy_4");
                  _loc5_.properties = _loc6_;
                  _loc7_ = param1.generateGangMemberPic(_loc6_.picID);
                  _loc7_.scaleX = _loc7_.scaleY = 0.25;
                  _loc5_.inUse.holder.addChild(_loc7_);
                  _loc5_.inUse.activBar.mouseEnabled = _loc5_.inUse.holder.mouseEnabled = _loc5_.inUse.holder.mouseChildren = false;
                  if(_loc6_.starCount > 0)
                  {
                     _loc5_.inUse.star.visible = true;
                  }
                  else
                  {
                     _loc5_.inUse.star.visible = false;
                  }
                  _loc5_.inUse.toolTipVO = new TooltipVO(MafiaGangMemberAdvancedTooltip.NAME,new MafiaGangMemberAdvancedTooltipProperties(_loc5_.properties,false));
               }
               else
               {
                  _loc5_.free.visible = true;
                  _loc5_.free.btn_hire.goldInfoVisible = false;
                  _loc5_.free.btn_hire.label = MafiaModel.languageData.getTextById("MafiaGangScreen_copy_3");
               }
            }
            else
            {
               _loc5_.locked.visible = true;
               _loc5_.locked.btn_unlock.goldInfoVisible = true;
               _loc5_.locked.btn_unlock.mc_unlock.txt_time.text = MafiaModel.goldConstants.unlockGangMemberSlot.toString();
               _loc5_.locked.btn_unlock.toolTipText = MafiaModel.languageData.getTextById("MafiaGangScreen_copy_5");
            }
            _loc3_++;
         }
      }
      
      private function fillGangShop(param1:Vector.<GangVO>) : void
      {
         var _loc3_:MafiaHireMember = null;
         var _loc4_:GangVO = null;
         var _loc5_:Sprite = null;
         this.gangScreen.hire.txt_title.text = MafiaModel.languageData.getTextById("MafiaGangScreen_copy_9");
         var _loc2_:int = 0;
         while(_loc2_ < MafiaGangData.MAXGANGMEMBERS)
         {
            _loc3_ = this.gangScreen.hire.getChildByName("hire" + _loc2_) as MafiaHireMember;
            MovieClipHelper.clearMovieClip(_loc3_.pic.holder);
            if(param1.length > this._gangShopIndex + _loc2_)
            {
               _loc4_ = param1[this._gangShopIndex + _loc2_];
               _loc3_.visible = true;
               _loc3_.properties = _loc4_;
               _loc5_ = MafiaModel.userData.gangData.generateGangMemberPic(_loc4_.picID);
               _loc3_.pic.holder.addChild(_loc5_);
               _loc3_.pic.mouseEnabled = _loc3_.pic.mouseChildren = false;
               _loc3_.info.visible = _loc3_.info.mouseEnabled = _loc3_.info.mouseChildren = false;
               _loc3_.info.txt_name.text = MafiaModel.languageData.getTextById("MafiaGangScreen_memberName_copy_" + _loc4_.picID);
               _loc3_.info.txt_effect.text = MafiaModel.languageData.getTextById("MafiaGangScreen_copy_1");
               _loc3_.info.txt_effectValue.text = MafiaModel.languageData.getTextById("MafiaGangScreen_memberEffect_copy_" + _loc4_.effectType,[_loc4_.effectValue]);
               _loc3_.info.txt_time.text = MafiaModel.languageData.getTextById("MafiaGangScreen_copy_2");
               _loc3_.info.txt_timeValue.text = TimeStringHelper.getTimeToString(_loc4_.duration * 24 * 60 * 60,TimeStringHelper.ONE_TIME_FORMAT,MafiaModel.languageData.getTextById);
               if(_loc4_.starCount > 0)
               {
                  _loc3_.pic.star.visible = true;
               }
               else
               {
                  _loc3_.pic.star.visible = false;
               }
               if(_loc4_.costC1)
               {
                  _loc3_.priceMC.gotoAndStop(1);
                  _loc3_.txt_price.text = NumberStringHelper.groupString(_loc4_.costC1,MafiaModel.languageData.getTextById);
               }
               if(_loc4_.costC2)
               {
                  _loc3_.priceMC.gotoAndStop(2);
                  _loc3_.txt_price.text = NumberStringHelper.groupString(_loc4_.costC2,MafiaModel.languageData.getTextById);
               }
            }
            else
            {
               _loc3_.visible = false;
            }
            _loc3_.btn_hire.toolTipText = MafiaModel.languageData.getTextById("MafiaGangScreen_copy_3");
            _loc2_++;
         }
         if(param1.length <= MafiaGangData.MAXGANGMEMBERS)
         {
            this.gangScreen.hire.btn_left.visible = false;
            this.gangScreen.hire.btn_right.visible = false;
         }
      }
      
      private function onChangeGangTimer(param1:MafiaGangEvent) : void
      {
         var _loc2_:GangVO = param1.params[0] as GangVO;
         var _loc3_:MafiaGangMember = this.gangScreen.getChildByName(this.MEMBERINSTANCENAME + _loc2_.index) as MafiaGangMember;
         _loc3_.inUse.activBar.bar.scaleX = param1.params[1];
         _loc3_.toolTipVO = new TooltipVO(MafiaGangMemberAdvancedTooltip.NAME,new MafiaGangMemberAdvancedTooltipProperties(_loc2_,false),null,"",BasicCustomCursor.CURSOR_ARROW);
      }
      
      private function onFireGangMember(param1:MafiaGangMember) : void
      {
         this.gangScreen.info.visible = false;
         this.gangScreen.hire.visible = false;
         this.gangScreen.fire.visible = true;
         var _loc2_:GangVO = param1.properties as GangVO;
         this._fireGangMemberSlotId = int(param1.name.substr(this.MEMBERINSTANCENAME.length));
         this.gangScreen.fire.btn_fire.label = MafiaModel.languageData.getTextById("MafiaGangScreen_copy_4");
         this.gangScreen.fire.txt_title.text = MafiaModel.languageData.getTextById("MafiaGangScreen_copy_7");
         this.gangScreen.fire.txt_copy.text = MafiaModel.languageData.getTextById("MafiaGangScreen_copy_8");
         this.gangScreen.fire.txt_effect.text = MafiaModel.languageData.getTextById("MafiaGangScreen_copy_1") + " " + MafiaModel.languageData.getTextById("MafiaGangScreen_memberEffect_copy_" + _loc2_.effectType,[_loc2_.effectValue]);
         this.gangScreen.fire.txt_time.text = MafiaModel.languageData.getTextById("MafiaGangScreen_copy_2") + " " + _loc2_.remainingTime;
         MovieClipHelper.clearMovieClip(this.gangScreen.fire.holder);
         var _loc3_:Sprite = MafiaModel.userData.gangData.generateGangMemberPic(_loc2_.picID);
         _loc3_.scaleX = _loc3_.scaleY = 0.25;
         this.gangScreen.fire.holder.addChild(_loc3_);
      }
      
      private function onClickHireOnGangMember(param1:MafiaGangMember) : void
      {
         this.onShowGangMemberShop();
         this._hireToSlotId = int(param1.name.substr(this.MEMBERINSTANCENAME.length));
      }
      
      private function onShowGangMemberShop() : void
      {
         this.gangScreen.info.visible = false;
         this.gangScreen.hire.visible = true;
         this.gangScreen.fire.visible = false;
      }
      
      private function onUnlockGangMemberSlot(param1:int) : void
      {
         if(MafiaModel.userData.gold >= MafiaModel.goldConstants.unlockGangMemberSlot)
         {
            MafiaModel.smartfoxClient.sendMessage(Constants_SFS.C2S_UNLOCK_GANG_SLOT,[param1]);
         }
         else
         {
            layoutManager.showDialog(MafiaNoGoldDialog.NAME,new BasicStandardYesNoDialogProperties(MafiaModel.languageData.getTextById("MafiaNoMoneyDialog_title"),MafiaModel.languageData.getTextById("MafiaNoMoneyForBuyItem_copy"),controller.onClickMoreMoney,null,null,MafiaModel.languageData.getTextById("MafiaPaymentDialog_btn_buygold"),MafiaModel.languageData.getTextById("generic_btn_close")));
         }
      }
      
      private function onHireGangMember(param1:MafiaHireMember) : void
      {
         this.isWaitingForServerMessage = true;
         var _loc2_:GangVO = param1.properties as GangVO;
         controller.sendServerMessageAndWait(Constants_SFS.C2S_HIRE_GANGMEMBER,[_loc2_.index,this._hireToSlotId],Constants_SFS.S2C_HIRE_GANGMEMBER);
      }
      
      override public function checkWaitingAnimState(param1:String) : void
      {
         if(param1 == Constants_SFS.S2C_HIRE_GANGMEMBER)
         {
            this.isWaitingForServerMessage = false;
         }
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         if(this.isWaitingForServerMessage)
         {
            return;
         }
         switch(param1.target)
         {
            case this.gangScreen.btn_close:
               layoutManager.state = Constants_LayoutStates.STATE_PROFILE;
               break;
            case this.gangScreen.member0.inUse.btn_fire:
            case this.gangScreen.member1.inUse.btn_fire:
            case this.gangScreen.member2.inUse.btn_fire:
            case this.gangScreen.member3.inUse.btn_fire:
            case this.gangScreen.member4.inUse.btn_fire:
               this.onFireGangMember((param1.target as MovieClip).parent.parent as MafiaGangMember);
               break;
            case this.gangScreen.member0.free.btn_hire:
            case this.gangScreen.member1.free.btn_hire:
            case this.gangScreen.member2.free.btn_hire:
            case this.gangScreen.member3.free.btn_hire:
            case this.gangScreen.member4.free.btn_hire:
               this.onClickHireOnGangMember((param1.target as MovieClip).parent.parent as MafiaGangMember);
               break;
            case this.gangScreen.member0.locked.btn_unlock:
               this.onUnlockGangMemberSlot(0);
               break;
            case this.gangScreen.member1.locked.btn_unlock:
               this.onUnlockGangMemberSlot(1);
               break;
            case this.gangScreen.member2.locked.btn_unlock:
               this.onUnlockGangMemberSlot(2);
               break;
            case this.gangScreen.member3.locked.btn_unlock:
               this.onUnlockGangMemberSlot(3);
               break;
            case this.gangScreen.member4.locked.btn_unlock:
               this.onUnlockGangMemberSlot(4);
               break;
            case this.gangScreen.fire.btn_fire:
               MafiaModel.smartfoxClient.sendMessage(Constants_SFS.C2S_FIRE_GANGMEMBER,[this._fireGangMemberSlotId]);
               this.gangScreen.fire.visible = false;
               break;
            case this.gangScreen.hire.hire0.btn_hire:
            case this.gangScreen.hire.hire1.btn_hire:
            case this.gangScreen.hire.hire2.btn_hire:
            case this.gangScreen.hire.hire3.btn_hire:
            case this.gangScreen.hire.hire4.btn_hire:
               this.onHireGangMember((param1.target as MovieClip).parent as MafiaHireMember);
               break;
            case this.gangScreen.hire.btn_left:
               if(this._gangShopIndex > 0)
               {
                  this._gangShopIndex--;
               }
               this.fillGangShop(MafiaModel.userData.gangData.shopGang);
               break;
            case this.gangScreen.hire.btn_right:
               if(this._gangShopIndex < MafiaModel.userData.gangData.shopGang.length)
               {
                  this._gangShopIndex++;
               }
               this.fillGangShop(MafiaModel.userData.gangData.shopGang);
         }
         super.onClick(param1);
      }
      
      override protected function onMouseOver(param1:MouseEvent) : void
      {
         switch(param1.target)
         {
            case this.gangScreen.hire.hire0.layerMC:
            case this.gangScreen.hire.hire1.layerMC:
            case this.gangScreen.hire.hire2.layerMC:
            case this.gangScreen.hire.hire3.layerMC:
            case this.gangScreen.hire.hire4.layerMC:
               this.onShowHireInfos((param1.target as MovieClip).parent as MafiaHireMember);
         }
         super.onMouseOver(param1);
      }
      
      private function onShowHireInfos(param1:MafiaHireMember) : void
      {
         param1.info.visible = true;
         param1.pic.visible = false;
      }
      
      override protected function onMouseOut(param1:MouseEvent) : void
      {
         switch(param1.target)
         {
            case this.gangScreen.hire.hire0.layerMC:
            case this.gangScreen.hire.hire1.layerMC:
            case this.gangScreen.hire.hire2.layerMC:
            case this.gangScreen.hire.hire3.layerMC:
            case this.gangScreen.hire.hire4.layerMC:
               this.onHideHireInfos((param1.target as MovieClip).parent as MafiaHireMember);
         }
         super.onMouseOut(param1);
      }
      
      private function onHideHireInfos(param1:MafiaHireMember) : void
      {
         param1.info.visible = false;
         param1.pic.visible = true;
      }
      
      protected function get gangScreen() : MafiaGang
      {
         return disp as MafiaGang;
      }
   }
}
