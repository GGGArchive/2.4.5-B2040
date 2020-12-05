package com.goodgamestudios.mafia.controller.commands.account
{
   import com.goodgamestudios.basic.model.BasicModel;
   import com.goodgamestudios.basic.view.BasicLayoutManager;
   import com.goodgamestudios.language.countryMapper.GGSCountryController;
   import com.goodgamestudios.mafia.constants.Constants_SFS;
   import com.goodgamestudios.mafia.constants.enums.CharacterClass;
   import com.goodgamestudios.mafia.constants.enums.CharacterGender;
   import com.goodgamestudios.mafia.controller.BasicProtobufCommand;
   import com.goodgamestudios.mafia.controller.ProtobufController;
   import com.goodgamestudios.mafia.controller.ProtobufEnumTranslator;
   import com.goodgamestudios.mafia.controller.protobuf.account.createavatar.PBAccountCreateAvatarRequest;
   import com.goodgamestudios.mafia.controller.protobuf.account.createavatar.PBAccountCreateAvatarResponse;
   import com.goodgamestudios.mafia.controller.protobuf.account.createavatar.response.PBAccountCreateAvatarResult;
   import com.goodgamestudios.mafia.event.model.MafiaUserEvent;
   import com.goodgamestudios.mafia.model.MafiaTutorialData;
   import com.netease.protobuf.Message;
   
   public class CreateAvatarCommand extends BasicProtobufCommand
   {
       
      
      public function CreateAvatarCommand()
      {
         super();
      }
      
      public static function sendCommand(param1:String, param2:CharacterClass, param3:CharacterGender) : void
      {
         var _loc4_:PBAccountCreateAvatarRequest = new PBAccountCreateAvatarRequest();
         _loc4_.portrait = param1;
         _loc4_.characterClass = ProtobufEnumTranslator.translateCharacterClassToProto(param2);
         _loc4_.gender = ProtobufEnumTranslator.translateCharacterGenderToProto(param3);
         ProtobufController.getInstance().sendRequest(_loc4_);
      }
      
      override public function executeCommand(param1:Message) : Boolean
      {
         var _loc2_:PBAccountCreateAvatarResponse = param1 as PBAccountCreateAvatarResponse;
         switch(_loc2_.result)
         {
            case PBAccountCreateAvatarResult.OK:
               MafiaTutorialData.getInstance().tutorialShown = false;
               controller.dispatchEvent(new MafiaUserEvent(MafiaUserEvent.CREATED_AVATAR_VALID));
               if(BasicLayoutManager.getInstance().currentState != BasicLayoutManager.STATE_REGISTRATION && !env.loginIsKeyBased)
               {
                  BasicModel.localData.saveLoginData(BasicModel.userData.loginName,BasicModel.userData.loginPwd,true);
                  BasicModel.localData.saveCountryData(GGSCountryController.instance.currentCountry.ggsCountryCode);
                  BasicModel.smartfoxClient.sendMessage(Constants_SFS.C2S_GET_ALLPLAYERDATA,[]);
                  layoutManager.onEndProgressbar();
               }
               return true;
            default:
               controller.dispatchEvent(new MafiaUserEvent(MafiaUserEvent.CREATED_AVATAR_INVALID));
               return false;
         }
      }
      
      override public function getRequestClass() : Class
      {
         return PBAccountCreateAvatarRequest;
      }
      
      override public function getResponseClass() : Class
      {
         return PBAccountCreateAvatarResponse;
      }
   }
}
