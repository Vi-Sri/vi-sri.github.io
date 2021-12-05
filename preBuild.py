import glob
import os
import yaml

def CountFrequency(my_list): 
    freq = {} 
    for item in my_list: 
        if (item in freq): 
            freq[item] += 1
        else: 
            freq[item] = 1
    return freq

def isNamePresent(stream, name, key):
    for i,val in enumerate(stream):
        if val[key] == name:
            return i, True
    return -1, False
        

post_dir = '_posts/'
tag_dir = 'tag/'
indexData = '_data/index.yml'
tagData = '_data/tags.yml'

filenames = glob.glob(post_dir + '*md')

with open(indexData, 'r') as indexFile:
    indexStream = yaml.load(indexFile, Loader=yaml.FullLoader)
indexFile.close()

tagStream = []

total_tags = []
total_categories = []
for filename in filenames:
    f = open(filename, 'r', encoding='utf8')
    crawl = False
    isTag = False
    isCategory = False
    for line in f:
        if crawl:
            current_tags = line.strip().split()
            if current_tags[0] == 'tags:':
                total_tags.extend(current_tags[1:])
                isTags = True
            if current_tags[0] == 'category:':
                total_categories.extend(current_tags[1:])
                isCategory = True
            if isTag and isCategory:
                crawl = False
                break
        if line.strip() == '---':
            if not crawl:
                crawl = True
            else:
                crawl = False
                break
    f.close()


tagDict = CountFrequency(total_tags)
categoryDict = CountFrequency(total_categories)

for tagName in tagDict.keys():
    index, flag = isNamePresent(tagStream, tagName, "name")
    if flag:
        tagStream[index]["count"] = tagDict[tagName]
    else:
        tagStream.append(
            {
                "name": tagName,
                "count": tagDict[tagName]
            }
        )

for categoryName in categoryDict.keys():
    index, flag = isNamePresent(indexStream, categoryName, "type")
    if flag:
        indexStream[index]["count"] = categoryDict[categoryName]
    else:
        indexStream.append(
            {
                "name": "N/A",
                "type": categoryName,
                "count": categoryDict[categoryName]
            }
        )
        
print("Index files updated..")

with open(indexData, "w") as indexFile:
    _ = yaml.dump(indexStream, indexFile)

with open(tagData, "w") as tagFile:
    _ = yaml.dump(tagStream, tagFile)

tagFile.close()
indexFile.close()

total_tags = set(total_tags)
old_tags = glob.glob(tag_dir + '*.md')
for tag in old_tags:
    os.remove(tag)
    
if not os.path.exists(tag_dir):
    os.makedirs(tag_dir)

for tag in total_tags:
    tag_filename = tag_dir + tag + '.md'
    f = open(tag_filename, 'w')
    write_str = '---\nlayout: tagpage\ntitle: \"Tags: ' + tag + '\"\ntags: ' + tag + '\ndescription: All the posts that are related to ' + tag +'\n---\n'
    f.write(write_str)
    f.close()
print("Tags generated, count", total_tags.__len__())