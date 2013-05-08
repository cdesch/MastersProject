__author__ = 'cj'
import sys
#import and init pygame
import pygame
from LPSprites import *

pygame.init()
screen=pygame.display.set_mode((640,480),0,32)

def setupSprites():


    #b = pygame.sprite.Sprite() # create sprite
    #b.image = pygame.image.load("ball.png").convert() # load ball image
    #b.rect = b.image.get_rect() # use image extent values
    #b.rect.topleft = [0, 0] # put the ball in the top left corner
    #window.blit(b.image, b.rect)


    pass



def main():


    background=pygame.Surface(screen.get_size())
    background=background.convert()
    background.fill((0,255,0))
    screen.blit(background,(0,0))

    #draw a line - see http://www.pygame.org/docs/ref/draw.html for more
    pygame.draw.line(screen, (255, 255, 255), (0, 0), (30, 50))

    #draw it to the screen
    pygame.display.flip()


    #setupSprites()
    '''
    transgroups = pygame.sprite.Group()
    TranslucentSprite.container = transgroups

    """Here's the Translucency Code"""
    transsurface = pygame.display.set_mode(screen.get_size())
    transsurface = transsurface.convert(screen)
    transsurface.fill((255,0,255))
    transsurface.set_colorkey((255,0,255))
    transsurface.set_alpha(50)

    TranslucentSprite()
    '''

    boxes=[]
    for i in xrange(0,10):
        boxes.append(LPBoxes())

    #circle=LPCircle()
    circle=Waves()
    allSprites=pygame.sprite.Group(boxes)
    circleSprite=pygame.sprite.Group(circle)


    #mygroup = pygame.sprite.Group()

    pygame.display.update()

    #input handling (somewhat boilerplate code):
    while True:
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                sys.exit(0)
            else:
                print event

                #following the CUD method
            #transgroups.draw(transsurface)

            allSprites.clear(screen,background)
            circleSprite.clear(screen,background)
            allSprites.update()
            circleSprite.update()
            allSprites.draw(screen)
            circleSprite.draw(screen)

            pygame.display.flip()


if __name__=='__main__':
    main()
