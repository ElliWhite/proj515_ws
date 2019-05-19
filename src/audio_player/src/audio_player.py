#!/usr/bin/env python
import rospy
from std_msgs.msg import String
from std_msgs.msg import Int16
import vlc
import glob
import time
from enum import Enum



def callback(data):
    file_name = data.data
    if any(file_name in s for s in audio_files):
        audio_instance = vlc.Instance()
        audio_player = audio_instance.media_player_new()
        audio = audio_instance.media_new(file_path + "/" + file_name + ".mp3")
        audio_player.set_media(audio)
        audio_player.play()
        time.sleep(0.5)
        current_state = audio_player.get_state()
        state_str = audio_state(current_state)
        pub.publish(state_str)
        while(1):
            current_state = audio_player.get_state()
            if current_state != vlc.State.Playing:
                state_str = audio_state(current_state)
                pub.publish(state_str)
                break
    else:
        rospy.loginfo("No audio file found for %s." % file_name)
        pub.publish("Error")
        

def audio_state(x):
    if x == vlc.State.NothingSpecial:
        y = "NothingSpecial"
    elif x ==  vlc.State.Opening:
        y = "Opening"
    elif x ==  vlc.State.Buffering:
        y = "Buffering"
    elif x ==  vlc.State.Playing:
        y = "Playing"
    elif x ==  vlc.State.Paused:
        y = "Paused"
    elif x ==  vlc.State.Stopped:
        y = "Stopped"
    elif x ==  vlc.State.Ended:
        y = "Ended"
    elif x ==  vlc.State.Error:
        y = "Error"
    else:
        y = "Unknown State"

    return y



if __name__ == '__main__':

    #file_path = rospy.get_param('audio_file_path')
    #at_topic = rospy.get_param('/at_topic')
    #as_topic = rospy.get_param('/as_topic')

    file_path = "/home/elliottwhite/proj515_ws/src/audio_player/src/audiofiles"
    at_topic = "/audio_trigger"
    as_topic = "/audio_status"

    audio_files = sorted(glob.glob(file_path + "/*"))
    num_files = len(audio_files)

    
    pub = rospy.Publisher(as_topic, String, queue_size=10)
    rospy.init_node('audio_player', anonymous=True)
    rospy.Subscriber(at_topic, String, callback)

    rospy.spin()

# 0: 'NothingSpecial',
# 1: 'Opening',
# 2: 'Buffering',
# 3: 'Playing',
# 4: 'Paused',
# 5: 'Stopped',
# 6: 'Ended',
# 7: 'Error'
