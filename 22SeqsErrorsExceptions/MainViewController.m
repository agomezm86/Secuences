//
//  MainViewController.m
//  22SeqsErrorsExceptions
//
//  Created by Alejandro Gomez on 30/01/14.
//  Copyright (c) 2014 Alejandro Gomez. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()
{
    BOOL turnoHumano;
    NSInteger currentIndex;
    NSInteger codigoProximoColor;
    BOOL bien;
}

@end

@implementation MainViewController

@synthesize sequencesArray;


#pragma mark - Init

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    //0 red
    //1 blue
    //2 green
    //3 yellow
    
    self.startButton.hidden = NO;
    self.statusLabel.hidden = YES;
    self.redButton.enabled = NO;
    self.blueButton.enabled = NO;
    self.greenButton.enabled = NO;
    self.yellowButton.enabled = NO;
    self.scoreLabel.text = @"";
    turnoHumano = NO;
}

- (void)validarTurno
{
    if (turnoHumano)
    {
        self.view.userInteractionEnabled = YES;
        [self actualizarStatusLabel:@"Tu turno!"];
        self.humanArray = [[NSMutableArray alloc] initWithArray:self.sequencesArray];
    }
    else
    {
        self.view.userInteractionEnabled = NO;
        [self actualizarStatusLabel:@"Espera..."];
        [self actualizarScoreLabel:[NSString stringWithFormat:@"Puntuación: %lu", (unsigned long)[self.sequencesArray count]]];
    }
}

- (void)validarProximoColor
{
    @try {
        codigoProximoColor = [[self.humanArray objectAtIndex:0]intValue];
    }
    @catch (NSException *exception) {
        NSLog(@"exception %@", [exception reason]);
    }
    @finally {
    }
}

- (void)eliminarObjetoDelArreglo
{
    [self.humanArray removeObjectAtIndex:0];
    if ([self.humanArray count] == 0)
    {
        bien = YES;
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Bien!!!" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }
}


#pragma mark - UILabel

- (void)actualizarStatusLabel:(NSString *)texto
{
    self.statusLabel.text = texto;
}

- (void)actualizarScoreLabel:(NSString *)texto
{
    self.scoreLabel.text = texto;
}


#pragma mark - UIButton

- (IBAction)startButtonPressed:(id)sender
{
    self.sequencesArray = [[NSMutableArray alloc] init];
    turnoHumano = NO;
    [self validarTurno];
    [self agregarObjetoAlArregloDeSecuencias];
    self.startButton.hidden = YES;
    self.statusLabel.hidden = NO;
    self.redButton.enabled = YES;
    self.blueButton.enabled = YES;
    self.greenButton.enabled = YES;
    self.yellowButton.enabled = YES;
}

- (IBAction)redButtonPressed:(id)sender
{
    if (codigoProximoColor == 0)
    {
        [self eliminarObjetoDelArreglo];
        [self validarProximoColor];
    }
    else
    {
        bien = NO;
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Mal!!!" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }
}

- (IBAction)blueButtonPressed:(id)sender
{
    if (codigoProximoColor == 1)
    {
        [self eliminarObjetoDelArreglo];
        [self validarProximoColor];
    }
    else
    {
        bien = NO;
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Mal!!!" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }
}

- (IBAction)greenButtonPressed:(id)sender
{
    if (codigoProximoColor == 2)
    {
        [self eliminarObjetoDelArreglo];
        [self validarProximoColor];
    }
    else
    {
        bien = NO;
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Mal!!!" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }
}

- (IBAction)yellowButtonPressed:(id)sender
{
    if (codigoProximoColor == 3)
    {
        [self eliminarObjetoDelArreglo];
        [self validarProximoColor];
    }
    else
    {
        bien = NO;
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Mal!!!" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }
}


#pragma mark - Arrays

- (void)agregarObjetoAlArregloDeSecuencias
{
    int num = arc4random()%4;
    [self.sequencesArray addObject:[NSString stringWithFormat:@"%d", num]];
    currentIndex = 0;
    [self mostrarAnimacionDeBotones];
}


#pragma mark - Animations

- (void)mostrarAnimacionDeBotones
{
    int num = [[self.sequencesArray objectAtIndex:currentIndex]intValue];
    UIButton *button = nil;
    UIColor *color = nil;
    switch (num) {
        case 0: button = self.redButton;
            color = [UIColor redColor];
            break;
        case 1: button = self.blueButton;
            color = [UIColor blueColor];
            break;
        case 2: button = self.greenButton;
            color = [UIColor greenColor];
            break;
        case 3: button = self.yellowButton;
            color = [UIColor yellowColor];
            break;
    }
    [button setBackgroundColor:[UIColor blackColor]];
    [UIView animateWithDuration:0.5
                     animations:^{
                         [button setCenter:button.center];
                         [button setAlpha:0.0];
                     } completion:^(BOOL finished) {
                         [button setBackgroundColor:color];
                         [button setAlpha:1.0];
                     }];
    
    if (currentIndex+1 >= [self.sequencesArray count])
    {
        turnoHumano = YES;
        currentIndex = 0;
        [self validarTurno];
        [self validarProximoColor];
    }
    else
    {
        currentIndex++;
        [self performSelector:@selector(mostrarAnimacionDeBotones) withObject:nil afterDelay:1.0f];
    }
}


#pragma mark - UIAlertView

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (bien)
    {
        bien = NO;
        turnoHumano = NO;
        [self validarTurno];
        [self agregarObjetoAlArregloDeSecuencias];
    }
    else
    {
        [self viewDidLoad];
    }
}


#pragma mark - Memory

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
