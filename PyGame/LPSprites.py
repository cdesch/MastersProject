__author__ = 'cj'


import pygame
from pygame.locals import *
import random


#creating the boxes
class LPBoxes(pygame.sprite.Sprite):
    def __init__(self):
        pygame.sprite.Sprite.__init__(self)
        self.image=pygame.Surface((50,50))
        self.image.fill((random.randint(0,255),random.randint(0,255),random.randint(0,255)))
        self.rect=self.image.get_rect()
        self.rect.center=(random.randint(0,255),random.randint(0,255))

#creating circle
class LPCircle(pygame.sprite.Sprite):
    def __init__(self):
        pygame.sprite.Sprite.__init__(self)
        self.image=pygame.Surface((50,50))
        self.image.fill((0,255,0))
        pygame.draw.circle(self.image,(255,0,0),(25,25),25,0)
        self.rect=self.image.get_rect()
    def update(self):
        self.rect.center=pygame.mouse.get_pos()


class LPFingerMarker(pygame.sprite.Sprite):
    def __init__(self):
        pygame.sprite.Sprite.__init__(self)

        self.image = pygame.Surface([25,25], pygame.SRCALPHA, 32)

        self.image=pygame.image.load("images/redcircle25.png").convert()
        self.image = self.image.convert_alpha()
        self.image.set_colorkey(-1,RLEACCEL)
        #self.rect=pygame.Rect(0,0,25,25)
        self.rect=self.image.get_rect()

    def update(self):
        self.rect.center=pygame.mouse.get_pos()

class Waves(pygame.sprite.Sprite):

    # Constructor. Pass in the color of the block,
    # and its x and y position
    def __init__(self):
        # Call the parent class (Sprite) constructor
        pygame.sprite.Sprite.__init__(self)

        # Create an image of the block, and fill it with a color.
        # This could also be an image loaded from the disk.
        self.image = pygame.image.load("images/redCircleWhite25.png").convert()
        # makes any white in the image transparent
        self.image.set_colorkey((255, 255, 255))
        self.rect = self.image.get_rect()
    def update(self):
        self.rect.center=pygame.mouse.get_pos()


class LPToolMarker(pygame.sprite.Sprite):
    def __init__(self):
        pygame.sprite.Sprite.__init__(self)
        self.image=pygame.Surface((50,50))
        self.image.fill((0,255,0))
        pygame.draw.circle(self.image,(255,0,0),(25,25),25,0)
        self.rect=self.image.get_rect()
    def update(self):
        self.rect.center=pygame.mouse.get_pos()

class LPBall(pygame.sprite.Sprite):
    def __init__(self):
        pygame.sprite.Sprite.__init__(self)
        self.image=pygame.image.load("ball.png").convert()
        self.rect=self.image.get_rect()
    def update(self):
        self.rect.center=pygame.mouse.get_pos()


        #b = pygame.sprite.Sprite() # create sprite
        #b.image = pygame.image.load("ball.png").convert() # load ball image
        #b.rect = b.image.get_rect() # use image extent values
        #b.rect.topleft = [0, 0] # put the ball in the top left corner
        #window.blit(b.image, b.rect)

class TranslucentSprite(pygame.sprite.Sprite):
    def __init__(self):
        pygame.sprite.Sprite.__init__(self, TranslucentSprite.container)
        self.image = pygame.image.load("images/reticle-tdot-red.png").convert()
        self.image.set_colorkey(-1, RLEACCEL)
        self.rect = self.image.get_rect()
        self.rect.center = (320,240)
