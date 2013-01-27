
// This file is part of Puzzle Master, a fun and addictive jigsaw puzzle game.
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 2 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program. If not, see <http://www.gnu.org/licenses/>.
//
// Copyright (C) 2010-2011, Timur Kristóf <venemo@fedoraproject.org>

#include <QPainter>
#include "imageprocessor.h"

namespace PuzzleHelpers
{

class ImageProcessorPrivate
{
    friend class ImageProcessor;
    QPixmap pixmap;
    QSize unit;
    QPixmap processImage(const QString &url, int width, int height);
};

QPixmap ImageProcessorPrivate::processImage(const QString &url, int width, int height)
{
    QString url2(url);
    if (url.contains(QRegExp("/[A-Za-z]:/")))
        url2.remove("file:///");
    else
        url2.remove("file://");
    QPixmap pix(url2);

    if (pix.isNull())
        return pix;

    // If the image is better displayed in "portrait mode", rotate it.
    if ((pix.width() < pix.height() && width >= height) || (pix.width() >= pix.height() && width < height))
    {
        pix = pix.scaledToHeight(width);
        QPixmap pix2(pix.height(), pix.width());
        QPainter p;
        p.begin(&pix2);
        p.rotate(-90);
        p.translate(- pix2.height(), 0);
        p.drawPixmap(0, 0, pix);
        p.end();
        pix = pix2;
    }

    // Scale it to our width
    if (pix.width() - 1 > width || pix.width() + 1 < width)
        pix = pix.scaledToWidth(width);

    // If still not good enough, just crop it
    if (pix.height() > height)
    {
        QPixmap pix2(width, height);
        QPainter p;
        p.begin(&pix2);
        p.drawPixmap(0, 0, pix, 0, (pix.height() - height) / 2, pix.width(), pix.height());
        p.end();
        pix = pix2;
    }

    return pix;
}

ImageProcessor::ImageProcessor(const QString &url, int width, int height, int rows, int cols)
{
    _p = new ImageProcessorPrivate();
    _p->pixmap = _p->processImage(url, width, height);
    _p->unit = QSize(_p->pixmap.width() / cols, _p->pixmap.height() / rows);
}

ImageProcessor::~ImageProcessor()
{
    delete _p;
}

bool ImageProcessor::isValid()
{
    return !_p->pixmap.isNull();
}

QSize ImageProcessor::unit()
{
    return _p->unit;
}

QSize ImageProcessor::pixmapSize()
{
    return _p->pixmap.size();
}

QPixmap ImageProcessor::drawPiece(int i, int j, int tabFull, const QSize &unit, const QPainterPath &shape, const PuzzleHelpers::Correction &corr)
{
    QPainter p;
    QPixmap px(unit.width() + corr.widthCorrection + 1, unit.height() + corr.heightCorrection + 1);
    px.fill(Qt::transparent);
    p.begin(&px);
    p.setRenderHint(QPainter::SmoothPixmapTransform);
    p.setRenderHint(QPainter::Antialiasing);
    p.setRenderHint(QPainter::HighQualityAntialiasing);
    p.setClipping(true);
    p.setClipPath(shape);
    p.drawPixmap(tabFull + corr.xCorrection + corr.sxCorrection, tabFull + corr.yCorrection + corr.syCorrection, _p->pixmap, i * unit.width() + corr.sxCorrection, j * unit.height() + corr.syCorrection, unit.width() * 2, unit.height() * 2);
    p.end();
    return px;
}

}
