#ifndef JIGSAWPUZZLEBOARD_H
#define JIGSAWPUZZLEBOARD_H

#include "puzzleboard.h"

class JigsawPuzzleItem;

class JigsawPuzzleBoard : public PuzzleBoard
{
    Q_OBJECT

public:
    explicit JigsawPuzzleBoard(QObject *parent = 0);
    void startGame(const QPixmap &pixmap, unsigned rows, unsigned cols);
    void setToleranceForPieces(int tolerance);
    void assemble();

protected:
    void accelerometerMovement(qreal x, qreal y, qreal z);

signals:
    void gameStarted();
    void gameWon();
    void shuffleComplete();
    void assembleComplete();

private slots:

public slots:
    void surrenderGame();
    void shuffle();
    void disable();
    void enable();

};

#endif // JIGSAWPUZZLEBOARD_H
