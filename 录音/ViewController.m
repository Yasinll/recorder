//
//  ViewController.m
//  录音
//
//  Created by PatrickY on 2018/1/3.
//  Copyright © 2018年 PatrickY. All rights reserved.
//

#import "ViewController.h"
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()

@property (strong, nonatomic) AVAudioRecorder   *recorder;
@property (strong, nonatomic) AVAudioPlayer     *player;


@end

@implementation ViewController

- (AVAudioRecorder *)recorder {
    
    if (!_recorder) {
        //保存路径
        NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/record"];
        NSURL *url = [NSURL fileURLWithPath:path];
        
        //录音设置
        NSMutableDictionary *settingDic = [NSMutableDictionary dictionary];
        //采样率
        [settingDic setValue:[NSNumber numberWithInt:44100] forKey:AVSampleRateKey];
        //格式
        [settingDic setValue:[NSNumber numberWithInt:kAudioFormatMPEG4AAC] forKey:AVFormatIDKey];
        //通道
        [settingDic setObject:[NSNumber numberWithInt:1] forKey:AVNumberOfChannelsKey];
        //质量
        [settingDic setObject:[NSNumber numberWithInt:AVAudioQualityHigh] forKey:AVEncoderAudioQualityKey];
        
        _recorder = [[AVAudioRecorder alloc] initWithURL:url settings:settingDic error:nil];
        
        //准备录音
        [_recorder prepareToRecord];
    }
    
    return _recorder;
    
}

- (AVAudioPlayer *)player {
    
    if (!_player) {
        
        //读取路径
        NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/record"];
        NSURL *url = [NSURL fileURLWithPath:path];
        
        _player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
        
        [_player prepareToPlay];
    }
    
    return _player;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

//录音
- (IBAction)record:(UIButton *)sender {
    
    if (sender.selected == NO) {
        [self.recorder record];
        sender.selected = YES;
    } else {
        [self.recorder stop];
        sender.selected = NO;
    }

}

//播放
- (IBAction)play:(UIButton *)sender {
    
    [self.player play];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
