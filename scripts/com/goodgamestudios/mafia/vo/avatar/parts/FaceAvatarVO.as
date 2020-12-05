package com.goodgamestudios.mafia.vo.avatar.parts
{
   import com.goodgamestudios.mafia.constants.Constants_Avatarparts;
   import com.goodgamestudios.mafia.constants.enums.CharacterGender;
   
   public class FaceAvatarVO extends BasicAvatarPartVO
   {
       
      
      public function FaceAvatarVO(param1:CharacterGender)
      {
         super();
         wodID = param1 == CharacterGender.Female?int(Constants_Avatarparts.FEMALE_FACE_WODID):int(Constants_Avatarparts.MALE_FACE_WODID);
      }
   }
}
