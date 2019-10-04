trigger CalloutTrigger on Account (before insert, before update) {
    CalloutClass.makeCallout();
}