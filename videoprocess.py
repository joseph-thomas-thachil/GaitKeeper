import numpy as np
import cv2

class vprocess :
    def __init__(self, url) :
        
        self.cap = cv2.VideoCapture(url)
        print(url)
        self.frame_width = int(self.cap.get(3))
        self.frame_height = int(self.cap.get(4))

        self.out_original = cv2.VideoWriter('cache/original.avi', cv2.VideoWriter_fourcc('X', 'V', 'I', 'D'), 30, (self.frame_width, self.frame_height))
        self.out_detect = cv2.VideoWriter('cache/detect.avi', cv2.VideoWriter_fourcc('X', 'V', 'I', 'D'), 30, (self.frame_width, self.frame_height))

        self.fgbg = cv2.bgsegm.createBackgroundSubtractorMOG()

        self.execute()

    def execute(self) :

        while True :

            status, frame = self.cap.read()

            if not status :
                break

            fgmask = self.fgbg.apply(frame)
            
            self.out_original.write(frame)
            self.out_detect.write(cv2.merge([fgmask, fgmask, fgmask]))

        print("processing done!")
        self.cap.release()
        self.out_detect.release()
        self.out_original.release()
            