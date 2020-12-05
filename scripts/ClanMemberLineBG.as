package
{
   import flash.display.MovieClip;
   
   public dynamic class ClanMemberLineBG extends MovieClip
   {
       
      
      public var btn_invite:Btn_InviteToClan;
      
      public var mc_goldTimer:GoldTimerInfoSimpleRightLong;
      
      public var btn_upgrade:Btn_UpgradeClan;
      
      public function ClanMemberLineBG()
      {
         super();
         addFrameScript(0,this.frame1);
      }
      
      function frame1() : *
      {
         stop();
      }
   }
}
