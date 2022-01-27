"""
Created on Mon Nov 29 2021

@author: Ngoc Pham (7891063)

Explanation:
    Download A3Q3.zip, extract the folder.
    User needs to import panda library!
    Run the main.py file. User will be prompted to enter names of two files which are names of two tables to join.
    Ideally, the files should be located at the same directory as main.py (this project).
    There are two sets of files to test:
        -people.txt and activities.txt
	    -TestLeft.csv and TestRight.txt
    User will also be prompted to type in the integer representing the type of join that he/she wants to use.
    Hit enter and check the output in the same directory as main.py file.
    User has to run the main.py again if he/she wants to do another join type execution.

    Note: The join removes the one of the duplicated columns (matching columns) for the output table.


"""
import os
import pandas as pd

def readInData(filename):
    try:
        records = []

        table = open(filename, "r")
        headings = table.readline().strip().split(',')

        for eachLine in table:
            data = tuple(eachLine.strip().split(','))
            records.append(data)

        table.close()

        return records, headings

    except Exception as e:
        print(e)

def on(headingsA, headingsB):   # getting the index of each table where they match
    matchedColumns = []
    for index_a, heading_a in enumerate(headingsA):
        for index_b, heading_b in enumerate(headingsB):
            if heading_a == heading_b:
                matchedColumnsTuple = (index_a, index_b)
                matchedColumns.append(matchedColumnsTuple)
    return matchedColumns


def naturalJoin(listA, listB, headingsA, headingsB, output_file):
    output_records = []
    matchedColumns = on(headingsA, headingsB)

    for itemA in listA:
        for itemB in listB:
            elements_A = []
            elements_B = []
            for columns in matchedColumns:
                elements_A.append(itemA[columns[0]])
                elements_B.append(itemB[columns[1]])
            if tuple(elements_A) == tuple(elements_B):
                output = (*itemA, *itemB)
                output_records.append(output)

    for columns in matchedColumns:
        headingsB[columns[1]] = "dup"
    output_headings = headingsA + headingsB

    file = pd.DataFrame(output_records, columns=output_headings)
    file.drop("dup", inplace=True, axis=1)
    file.to_csv(output_file, index=False)


    if os.stat(output_file).st_size == 0:   # if nothing matches, do Cartesian product
        output_records = []
        for itemA in listA:
            for itemB in listB:
                output = (*itemA, *itemB)
                output_records.append(output)
        file = pd.DataFrame(output_records, columns=output_headings)
        file.to_csv(output_file, index=False)

def leftJoin(listA, listB, headingsA, headingsB, output_file):
    output_records = []
    matchedColumns = on(headingsA, headingsB)

    for itemA in listA:
        match = 0
        for itemB in listB:
            elements_A = []
            elements_B = []
            for columns in matchedColumns:
                elements_A.append(itemA[columns[0]])
                elements_B.append(itemB[columns[1]])
            if tuple(elements_A) == tuple(elements_B):
                output = (*itemA, *itemB)
                output_records.append(output)
                match = 1
        if match == 0:
            itemB = ["NULL"] * len(itemB)
            output = (*itemA, *itemB)
            output_records.append(output)

    headingsB_dup = headingsB.copy()
    for columns in matchedColumns:
        headingsB_dup[columns[1]] = "dup"
    output_headings = headingsA + headingsB_dup

    file = pd.DataFrame(output_records, columns=output_headings)
    file.drop("dup", inplace=True, axis=1)
    file.to_csv(output_file, index=False)


def rightJoin(listA, listB, headingsA, headingsB, output_file):
    output_records = []
    matchedColumns = on(headingsA, headingsB)

    for itemB in listB:
        match = 0
        for itemA in listA:
            elements_A = []
            elements_B = []
            for columns in matchedColumns:
                elements_A.append(itemA[columns[0]])
                elements_B.append(itemB[columns[1]])
            if tuple(elements_A) == tuple(elements_B):
                output = (*itemA, *itemB)
                output_records.append(output)
                match = 1
        if match == 0:
            itemA = ["NULL"] * len(itemA)
            output = (*itemA, *itemB)
            output_records.append(output)

    headingsA_dup = headingsA.copy()
    for columns in matchedColumns:
        headingsA_dup[columns[0]] = "dup"
    output_headings = headingsA_dup + headingsB

    file = pd.DataFrame(output_records, columns=output_headings)
    file.drop("dup", inplace=True, axis=1)
    file.to_csv(output_file, index=False)



def fullOuterJoin(listA, listB, headingsA, headingsB, output_file):
    leftJoin(listA, listB, headingsA, headingsB, "temp_leftjoin.csv")
    rightJoin(listA, listB, headingsA, headingsB, "temp_rightjoin.csv")

    data_temp_leftjoin = pd.read_csv("temp_leftjoin.csv")
    data_temp_rightjoin = pd.read_csv("temp_rightjoin.csv")

    concatenated = pd.concat([data_temp_leftjoin, data_temp_rightjoin])
    output = concatenated.drop_duplicates()
    output.to_csv(output_file, index=False, na_rep='NULL')

    os.remove("temp_leftjoin.csv")
    os.remove("temp_rightjoin.csv")



# main
# User can try TestLeft.csv, TestRight.csv which are provided from professor as well.
fileA = input("First table (i.e: people.txt):\n")
fileB = input("Second table (i.e: activities.txt):\n")
join_type = int( input("Choose type of join (type in number, then hit Enter):\n 1. natural join\n 2. left join\n 3. right join\n 4. full outter join\n") )

listA, headingsA = readInData(fileA)
listB, headingsB = readInData(fileB)

if join_type == 1:
    naturalJoin(listA, listB, headingsA, headingsB, "1_natural_join.csv")
elif join_type == 2:
    leftJoin(listA, listB, headingsA, headingsB, "2_left_join.csv")
elif join_type == 3:
    rightJoin(listA, listB, headingsA, headingsB, "3_right_join.csv")
elif join_type == 4:
    fullOuterJoin(listA, listB, headingsA, headingsB, "4_full_outer_join.csv")

print("Check .csv output at same directory as main.py")


