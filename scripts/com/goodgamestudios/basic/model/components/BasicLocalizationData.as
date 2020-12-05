package com.goodgamestudios.basic.model.components
{
   import com.goodgamestudios.basic.constants.BasicConstants;
   import com.goodgamestudios.basic.model.vo.InstanceVO;
   
   public class BasicLocalizationData
   {
       
      
      private var _usernameMinLength:int;
      
      public function BasicLocalizationData()
      {
         super();
      }
      
      public function setUsernameMinLengthByCountry() : void
      {
         var _loc1_:InstanceVO = new InstanceVO();
         if(_loc1_.instanceId == 26 || _loc1_.instanceId == 24 || _loc1_.instanceId == 27)
         {
            this._usernameMinLength = BasicConstants.USERNAME_MIN_LENGTH_ASIA;
         }
         else
         {
            this._usernameMinLength = BasicConstants.USERNAME_MIN_LENGTH;
         }
      }
      
      public function get getUsernameMinLength() : int
      {
         return this._usernameMinLength;
      }
      
      public function set setUsernameMinLength(param1:int) : void
      {
         this._usernameMinLength = param1;
      }
   }
}
