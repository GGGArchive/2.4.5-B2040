package com.goodgamestudios.mafia.view.screens.firstVisit
{
   import com.goodgamestudios.basic.IEnvironmentGlobals;
   import com.goodgamestudios.basic.constants.CommonGameStates;
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.basic.event.BasicComboboxEvent;
   import com.goodgamestudios.basic.event.BasicFirstVisitEvent;
   import com.goodgamestudios.basic.event.SmartfoxEvent;
   import com.goodgamestudios.basic.model.BasicModel;
   import com.goodgamestudios.basic.model.components.BasicSmartfoxClient;
   import com.goodgamestudios.basic.model.components.BasicSocialData;
   import com.goodgamestudios.basic.model.vo.InstanceVO;
   import com.goodgamestudios.basic.view.BasicComboboxComponent;
   import com.goodgamestudios.basic.view.BasicCustomCursor;
   import com.goodgamestudios.basic.view.BasicLanguageFontManager;
   import com.goodgamestudios.basic.view.TextValide;
   import com.goodgamestudios.commanding.CommandController;
   import com.goodgamestudios.language.countryMapper.GGSCountryController;
   import com.goodgamestudios.mafia.MafiaEnvironmentGlobals;
   import com.goodgamestudios.mafia.constants.Constants_Basic;
   import com.goodgamestudios.mafia.constants.Constants_SFS;
   import com.goodgamestudios.mafia.constants.enums.CharacterGender;
   import com.goodgamestudios.mafia.controller.commands.account.CreateAvatarCommand;
   import com.goodgamestudios.mafia.helper.AvatarHelper;
   import com.goodgamestudios.mafia.model.components.MafiaSmartfoxClient;
   import com.goodgamestudios.mafia.vo.avatar.AvatarVO;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.MouseEvent;
   import flash.external.ExternalInterface;
   
   public class MafiaSocialAvatarScreen extends MafiaAvatarScreen
   {
       
      
      private var nameSelection:MafiaFirstVisitNameSelection;
      
      private var worldSelectionBox:BasicComboboxComponent;
      
      private var noConnectionDialog:MafiaStandardOk;
      
      public function MafiaSocialAvatarScreen(param1:MovieClip, param2:BasicCustomCursor, param3:AvatarVO = null, param4:Function = null, param5:Function = null, param6:Sprite = null, param7:EventDispatcher = null, param8:Boolean = false)
      {
         var _loc11_:InstanceVO = null;
         var _loc12_:Object = null;
         super(param1,param2,param3,param4,param5,param6,param7,param8);
         MafiaDataHolder.instance.firstVisitCreationUsed = true;
         param1.visible = false;
         param1.mc_languagechoise.visible = false;
         param1.btn_ok.enableButton = false;
         this.nameSelection = new MafiaFirstVisitNameSelection(new NameSelection());
         param1.addChild(this.nameSelection.disp);
         this.worldSelectionBox = new BasicComboboxComponent(new BasicCombobox(),BasicComboboxItem);
         param1.addChild(this.worldSelectionBox.disp);
         this.worldSelectionBox.disp.addEventListener(BasicComboboxEvent.COMBOBOXCHANGE,this.onChangeWorld);
         this.worldSelectionBox.disp.visible = false;
         var _loc9_:Vector.<InstanceVO> = BasicModel.instanceProxy.getInstancesForActualCountry();
         var _loc10_:int = 0;
         while(_loc10_ < _loc9_.length)
         {
            _loc11_ = _loc9_[_loc10_] as InstanceVO;
            _loc12_ = {
               "label":_loc11_.serverName,
               "data":_loc11_
            };
            this.worldSelectionBox.addItem(_loc12_);
            _loc10_++;
         }
         param1.txt_nameInput.maxChars = 15;
      }
      
      private function onChangeWorld(param1:Event) : void
      {
         var _loc2_:InstanceVO = null;
         if(param1)
         {
            _loc2_ = this.worldSelectionBox.selectedData as InstanceVO;
            BasicModel.instanceProxy.selectedInstanceVO = _loc2_;
         }
         else
         {
            _loc2_ = BasicModel.instanceProxy.selectedInstanceVO;
         }
         this.doConnect(_loc2_);
      }
      
      public function doConnect(param1:InstanceVO) : void
      {
         BasicModel.smartfoxClient.executeConnection(param1.ip,param1.port);
      }
      
      override protected function initAvatar(param1:CharacterGender) : void
      {
      }
      
      override protected function onDispAddedToStage(param1:Event) : void
      {
         super.onDispAddedToStage(param1);
         BasicModel.smartfoxClient = new MafiaSmartfoxClient();
         BasicModel.smartfoxClient.debugMode = this.env.isTest || this.env.isLocal || this.env.isDevTest;
         BasicModel.smartfoxClient.addEventListener(SmartfoxEvent.CONNECT_SUCCESS,this.onSmartfoxEvent);
         BasicModel.smartfoxClient.addEventListener(SmartfoxEvent.CONNECT_FAILED,this.onSmartfoxEvent);
         BasicModel.smartfoxClient.addEventListener(SmartfoxEvent.CONNECT_TIMEOUT,this.onSmartfoxEvent);
         if(!BasicModel.smartfoxClient.isConnected)
         {
            if(this.env.isTest || this.env.isLocal || this.env.isDevTest)
            {
               this.worldSelectionBox.disp.visible = true;
               disp.visible = true;
            }
            else
            {
               this.onChangeWorld(null);
            }
         }
      }
      
      override protected function onRemoveDisp(param1:Event) : void
      {
         BasicModel.smartfoxClient.removeEventListener(SmartfoxEvent.CONNECT_SUCCESS,this.onSmartfoxEvent);
         BasicModel.smartfoxClient.removeEventListener(SmartfoxEvent.CONNECT_FAILED,this.onSmartfoxEvent);
         BasicModel.smartfoxClient.removeEventListener(SmartfoxEvent.CONNECT_TIMEOUT,this.onSmartfoxEvent);
         BasicModel.smartfoxClient.removeEventListener(SmartfoxEvent.JOINED_ROOM,this.onJoinedRoom);
         BasicModel.smartfoxClient.removeEventListener(SmartfoxEvent.EXTENSION_RESPONSE,this.onExtensionResponse);
         BasicModel.smartfoxClient.removeEventListener(SmartfoxEvent.CONNECTION_LOST,this.onConnectionLost);
         this.nameSelection.destroy();
         super.onRemoveDisp(param1);
      }
      
      private function onSmartfoxEvent(param1:SmartfoxEvent) : void
      {
         trace("smartfoxevent: " + param1.type);
         switch(param1.type)
         {
            case SmartfoxEvent.CONNECT_SUCCESS:
               if(!BasicModel.smartfoxClient.hasEventListener(SmartfoxEvent.JOINED_ROOM))
               {
                  BasicModel.smartfoxClient.addEventListener(SmartfoxEvent.JOINED_ROOM,this.onJoinedRoom);
               }
               if(!BasicModel.smartfoxClient.hasEventListener(SmartfoxEvent.EXTENSION_RESPONSE))
               {
                  BasicModel.smartfoxClient.addEventListener(SmartfoxEvent.EXTENSION_RESPONSE,this.onExtensionResponse);
               }
               if(!BasicModel.smartfoxClient.hasEventListener(SmartfoxEvent.CONNECTION_LOST))
               {
                  BasicModel.smartfoxClient.addEventListener(SmartfoxEvent.CONNECTION_LOST,this.onConnectionLost);
               }
               break;
            case SmartfoxEvent.CONNECT_FAILED:
               this.showNoConnectionDialog();
               break;
            case SmartfoxEvent.CONNECT_TIMEOUT:
               this.showNoConnectionDialog();
         }
      }
      
      public function onSelectInsance() : void
      {
      }
      
      private function showNoConnectionDialog() : void
      {
         disp.visible = true;
         this.noConnectionDialog = new MafiaStandardOk();
         this.noConnectionDialog.x = 400;
         this.noConnectionDialog.y = 340;
         this.noConnectionDialog.btn_ok.visible = false;
         this.noConnectionDialog.txt_title.text = BasicModel.languageData.getTextById("generic_alert_connection_failed_title");
         this.noConnectionDialog.txt_copy.text = BasicModel.languageData.getTextById("generic_alert_connection_failed_copy");
         var _loc1_:Shape = new Shape();
         _loc1_.graphics.beginFill(2372667);
         _loc1_.graphics.drawRect(0,0,Constants_Basic.GAME_WIDTH,Constants_Basic.GAME_HEIGHT);
         _loc1_.graphics.endFill();
         disp.addChild(_loc1_);
         disp.addChild(this.noConnectionDialog);
      }
      
      protected function onConnectionLost(param1:SmartfoxEvent) : void
      {
      }
      
      protected function onJoinedRoom(param1:SmartfoxEvent) : void
      {
         trace("onJoinedRoom!");
         if(param1.params[0] == BasicSmartfoxClient.LOBBY_ROOM_NAME)
         {
            if(this.env.pln != "" && this.env.sig != "")
            {
               BasicModel.smartfoxClient.sendMessage(Constants_SFS.C2S_IS_SOCIAL_AVATAR_CREATED,[this.env.pln,this.env.sig,this.env.networkId]);
            }
         }
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         if(param1.target is ColorChoiceButton)
         {
            return;
         }
         if(this.noConnectionDialog)
         {
            if(ExternalInterface.available)
            {
               ExternalInterface.call(BasicSocialData.RELOAD);
            }
            return;
         }
         switch(param1.target)
         {
            case disp.btn_ok:
            case disp.btn_ok.mc_background:
               if(!disp.btn_ok.enabled)
               {
                  return;
               }
               saveData();
               CreateAvatarCommand.sendCommand(AvatarHelper.createSFStringFromAvatarVO(MafiaDataHolder.instance.savedAvatarVO),MafiaDataHolder.instance.savedAvatarVO.characterClass,MafiaDataHolder.instance.savedAvatarVO.gender);
               disp.btn_ok.enableButton = false;
               break;
            case disp.txt_nameInput:
               this.nameSelection.hide();
               break;
            default:
               super.onClick(param1);
         }
      }
      
      override protected function onCursorOver(param1:MouseEvent) : void
      {
         if(this.noConnectionDialog)
         {
            cursor.setCursorType(BasicCustomCursor.CURSOR_CLICK);
         }
         else
         {
            super.onCursorOver(param1);
         }
      }
      
      override protected function onCursorOut(param1:MouseEvent) : void
      {
         if(this.noConnectionDialog)
         {
            cursor.setCursorType(BasicCustomCursor.CURSOR_ARROW);
         }
         else
         {
            super.onCursorOut(param1);
         }
      }
      
      protected function onExtensionResponse(param1:SmartfoxEvent) : void
      {
         var newNames:Array = null;
         var i:uint = 0;
         var event:SmartfoxEvent = param1;
         trace("onExtensionResponse!");
         switch(event.cmdId)
         {
            case Constants_SFS.PROTOBUF_CREATE_AVATAR:
               if(!TextValide.isSmartFoxValide(disp.txt_nameInput.text) || disp.txt_nameInput.text.length == 0)
               {
                  newNames = new Array();
                  i = 0;
                  while(i < 5)
                  {
                     newNames.push(TextValide.getCleanText(this.env.displayName).slice(0,13) + "1" + String(i + 1));
                     i++;
                  }
                  newNames.push("");
                  this.onOfferName([5,0,newNames.join("#")]);
                  return;
               }
               BasicModel.smartfoxClient.sendMessage(Constants_SFS.C2S_LOGIN_SET_NAME,[disp.txt_nameInput.text,0]);
               break;
            case Constants_SFS.S2C_LOGIN_SET_NAME:
               disp.btn_ok.enableButton = true;
               if(event.params[1] == 0)
               {
                  if(event.params[0] == 4 || event.params[0] == 5)
                  {
                     this.onOfferName(event.params);
                  }
                  else
                  {
                     dispatchEvent(new BasicFirstVisitEvent(BasicFirstVisitEvent.AVATARCREATION_FINISHED));
                     CommandController.instance.executeCommand(BasicController.COMMAND_USERTUNNEL_STATE,CommonGameStates.AVATAR_CREATION_FINISHED);
                  }
               }
               else if(event.params[0] == 4 || event.params[0] == 5)
               {
                  this.onOfferName(event.params);
               }
               break;
            case Constants_SFS.S2C_IS_SOCIAL_AVATAR_CREATED:
               if(event.params[1] == 0)
               {
                  disp.visible = true;
                  BasicModel.smartfoxClient.sendMessage(Constants_SFS.C2S_LOGIN_SET_NAME,[disp.txt_nameInput.text,1]);
                  super.initAvatar(this.env.gender == "female"?CharacterGender.Female:CharacterGender.Male);
                  disp.btn_ok.enableButton = true;
                  if(ExternalInterface.available)
                  {
                     try
                     {
                        ExternalInterface.call("setLanguage",GGSCountryController.instance.currentCountry.ggsCountryCode);
                     }
                     catch(e:Error)
                     {
                        trace("Calling javascript function \'setLanguage\' failed!");
                     }
                  }
               }
               else
               {
                  dispatchEvent(new BasicFirstVisitEvent(BasicFirstVisitEvent.AVATARCREATION_FINISHED));
                  CommandController.instance.executeCommand(BasicController.COMMAND_USERTUNNEL_STATE,CommonGameStates.AVATAR_CREATION_FINISHED);
               }
         }
      }
      
      override protected function updateFonts() : void
      {
         super.updateFonts();
         if(disp.txt_name)
         {
            BasicLanguageFontManager.getInstance().changeFontByLanguage(disp.txt_name);
         }
      }
      
      override protected function fillTexts() : void
      {
         super.fillTexts();
         disp.txt_name.text = BasicModel.languageData.getTextById("MafiaRegisterGuestDialog_copy_13");
         disp.txt_nameInput.text = this.env.displayName.slice(0,15);
         disp.btn_registered_already.visible = false;
      }
      
      private function onOfferName(param1:Array) : void
      {
         disp.btn_ok.enableButton = true;
         var _loc2_:Array = String(param1[2]).split("#");
         var _loc3_:Array = [];
         var _loc4_:uint = 0;
         while(_loc4_ < _loc2_.length)
         {
            _loc3_.push(_loc2_[_loc4_]);
            _loc4_++;
         }
         _loc3_.pop();
         var _loc5_:* = param1[1] == 1;
         if(!_loc5_)
         {
            this.nameSelection.setDisplayTarget(disp.txt_nameInput);
            this.nameSelection.onNameSelectedFunction = this.onSelectedName;
            trace(_loc3_);
            this.nameSelection.showNames(_loc3_,param1[0],BasicModel.languageData);
         }
         else
         {
            disp.txt_nameInput.text = _loc3_[0];
         }
      }
      
      private function onSelectedName(param1:String) : void
      {
         disp.txt_nameInput.text = param1;
      }
      
      private function get env() : IEnvironmentGlobals
      {
         return new MafiaEnvironmentGlobals();
      }
   }
}
