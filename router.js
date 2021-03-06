var express = require('express')
var mysql = require('mysql')
var router = express.Router()

router.post("/newjuejin", function(req, res){
        res.setHeader("Access-Control-Allow-Origin", "*")
        var con = mysql.createConnection({
                "host":"localhost",
                "user":"root",
                "password":"897011805",
                "database":"yhj"
        })
        var body = req.body //JSON.parse(req.body)
        var originalUrl = "";
        var screenshot = "";
        var viewCount = "";
        var summaryInfo = "";
        var content = "";
        var title = "";
        if (body.originalUrl) {
            originalUrl = body.originalUrl
        } else {
            res.send(JSON.stringify({"error":"originalUrl是必要的"}))
            return
        }
        if (body.screenshot) {
            screenshot = body.screenshot
        } else {
            res.send(JSON.stringify({"error":"screenshot是必要的"}))
            return
        }
        if (body.viewCount) {
            viewCount = body.viewCount
        } else {
            res.send(JSON.stringify({"error":"viewCount是必要的"}))
            return
        }
        if (body.summaryInfo) {
            summaryInfo = body.summaryInfo
        } else {
            res.send(JSON.stringify({"error":"summaryInfo是必要的"}))
            return
        }
        if (body.content) {
            content = body.content
        } else {
            res.send(JSON.stringify({"error":"content是必要的"}))
            return
        }
        if (body.title) {
            title = body.title
        } else {
            res.send(JSON.stringify({"error":"title是必要的"}))
            return
        }
        var date = Date.parse(new Date())
        var sql = "insert into juejin values ("+date+","+date+","+"\""+ originalUrl+"\""+","+"\""+screenshot+"\""+","+"\""+viewCount+"\""+","+"\""+summaryInfo+"\""+","+"\""+content+"\""+","+"\""+title+"\""+","+0+")"

        console.log("。。。。。。", sql)
        con.query(sql, function(err, results){
                if (err) throw err;
                res.send(JSON.stringify({"success":"success"}))
        })
})

router.post('/delete', function(req, res){
    res.setHeader('Content-Type','application/json;charset=utf-8')
    res.setHeader('Access-Control-Allow-origin', '*')
    var id = ''
    console.log('...........'+req.body)
    if (req.body.id){
        id = req.body.id;
    } else {
        res.send(JSON.stringify({"error":'不能识别'}))
        return;
    }
    var sql = "delete from juejin where id = "+id
    var con = mysql.createConnection({
        "host":"localhost",
        "user":"root",
        "password":"897011805",
        "database":"yhj"
    })
    con.query(sql, function(err, results){
        if (err) throw err;
        res.send(JSON.stringify({"success":"删除成功"}))
    })
})

router.get('/search', function(req, res){
    res.setHeader('Content-Type', 'applpcation/json;charset=utf-8')
    res.setHeader('Access-Control-Allor-Origin', '*')
    var keyword = "";
    if (req.query.keyword){
        keyword = req.query.keyword
    } else {
        res.send(JSON.stringify({"error":'不能识别'}))
        return;
    }

    var sql = "select *from juejin where title like " + "\"%" + keyword + "\""
    console.log("................", sql)
    var con = mysql.createConnection({
        "host":"localhost",
        "user":"root",
        "password":"897011805",
        "database":"yhj"
    })
    con.query(sql, function(err, results){
        if (err) throw err;
        var datas=[];
        for (var i=0; i<results.length; i++){
            var va = results[i]
            var value = {"buildTime":va['buildTime'], "updatedAt":va["updatedAt"], "originalUrl":va["originalUrl"], "screenshot":va["screenshot"], "content":va["content"], "title":va["title"], "viewsCount":va["viewsCount"], "summaryInfo":va["summaryInfo"], "id":va["id"]}
            datas.push(value)
        }
        res.send(JSON.stringify({"data":datas}))
    })
})

router.get('/juejin', function(req, res){
        res.setHeader("Content-Type",'application/json;charset=utf-8')
        res.setHeader("Access-Control-Allow-Origin", "*")
        var con = mysql.createConnection({
                'host':'localhost',
                'user':'root',
                'password':'897011805',
                'database':'yhj'
        })
        var pagesize = 20
        if (req.query['pagesize']){
                pagesize=req.query['pagesize']
        }
        var sql = "select * from juejin limit "+pagesize
        console.log('xxxxxxxxxxxxxx', sql)
        con.query(sql, function(err, results){
                if (err) throw err;
                var datas=[];
                for (var i=0; i<results.length; i++){
                    var va = results[i]
                    var value = {"buildTime":va['buildTime'], "updatedAt":va["updatedAt"], "originalUrl":va["originalUrl"], "screenshot":va["screenshot"], "content":va["content"], "title":va["title"], "viewsCount":va["viewsCount"], "summaryInfo":va["summaryInfo"], "id":va["id"]}
                    datas.push(value)
                }
                res.send(JSON.stringify({"data":datas}))
        })
})

module.exports = router